"""Minimal PNG reader/writer (stdlib only) for 8-bit RGB/RGBA/greyscale/palette, non-interlaced."""
import struct
import zlib

_SIG = b"\x89PNG\r\n\x1a\n"


def _paeth(a, b, c):
    p = a + b - c
    pa, pb, pc = abs(p - a), abs(p - b), abs(p - c)
    if pa <= pb and pa <= pc:
        return a
    return b if pb <= pc else c


def read(path):
    """Returns (width, height, rows) where rows is a list of lists of (r, g, b, a) tuples."""
    with open(path, "rb") as f:
        data = f.read()
    if not data.startswith(_SIG):
        raise ValueError(f"{path}: not a PNG")
    pos, idat, palette, trns = 8, b"", None, None
    width = height = depth = ctype = interlace = None
    while pos < len(data):
        length, kind = struct.unpack(">I4s", data[pos:pos + 8])
        chunk = data[pos + 8:pos + 8 + length]
        pos += 12 + length
        if kind == b"IHDR":
            width, height, depth, ctype, _, _, interlace = struct.unpack(">IIBBBBB", chunk)
        elif kind == b"PLTE":
            palette = [tuple(chunk[i:i + 3]) for i in range(0, len(chunk), 3)]
        elif kind == b"tRNS":
            trns = chunk
        elif kind == b"IDAT":
            idat += chunk
        elif kind == b"IEND":
            break
    if depth != 8 or interlace:
        raise ValueError(f"{path}: only 8-bit non-interlaced PNGs are supported")
    channels = {0: 1, 2: 3, 3: 1, 4: 2, 6: 4}[ctype]
    stride = width * channels
    raw = zlib.decompress(idat)
    rows, prev = [], bytearray(stride)
    i = 0
    for _ in range(height):
        ftype = raw[i]
        line = bytearray(raw[i + 1:i + 1 + stride])
        i += 1 + stride
        for x in range(stride):
            a = line[x - channels] if x >= channels else 0
            b = prev[x]
            c = prev[x - channels] if x >= channels else 0
            if ftype == 1:
                line[x] = (line[x] + a) & 255
            elif ftype == 2:
                line[x] = (line[x] + b) & 255
            elif ftype == 3:
                line[x] = (line[x] + ((a + b) >> 1)) & 255
            elif ftype == 4:
                line[x] = (line[x] + _paeth(a, b, c)) & 255
        prev = line
        px = []
        for x in range(width):
            s = line[x * channels:(x + 1) * channels]
            if ctype == 6:
                px.append(tuple(s))
            elif ctype == 2:
                px.append((s[0], s[1], s[2], 255))
            elif ctype == 0:
                px.append((s[0], s[0], s[0], 255))
            elif ctype == 4:
                px.append((s[0], s[0], s[0], s[1]))
            else:
                r, g, b_ = palette[s[0]]
                alpha = trns[s[0]] if trns and s[0] < len(trns) else 255
                px.append((r, g, b_, alpha))
        rows.append(px)
    return width, height, rows


def write(path, width, height, rows):
    """Writes RGBA rows (list of lists of 4-tuples) as a PNG."""
    raw = b"".join(b"\x00" + bytes(c for p in row for c in p) for row in rows)

    def chunk(kind, payload):
        return struct.pack(">I", len(payload)) + kind + payload + struct.pack(">I", zlib.crc32(kind + payload) & 0xFFFFFFFF)

    with open(path, "wb") as f:
        f.write(_SIG)
        f.write(chunk(b"IHDR", struct.pack(">IIBBBBB", width, height, 8, 6, 0, 0, 0)))
        f.write(chunk(b"IDAT", zlib.compress(raw, 9)))
        f.write(chunk(b"IEND", b""))
