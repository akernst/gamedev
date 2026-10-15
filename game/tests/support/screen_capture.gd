extends SceneTree
## Captures a scene at several window sizes (phone aspect ratios) to PNG.
## Usage (needs a display): godot --path game -s res://tests/support/screen_capture.gd -- \
##   --scene res://scenes/main.tscn --out /abs/dir --sizes 720x1280,1080x2400 [--frames 30]
## Each PNG is the game's own render buffer: base resolution, widened or heightened by aspect=expand.

var _sizes: Array[Vector2i] = []
var _out := ""
var _frames := 30
var _index := 0
var _wait := 0


func _initialize() -> void:
	var args := OS.get_cmdline_user_args()
	var scene_path := "res://scenes/main.tscn"
	for i in args.size():
		var next: String = args[i + 1] if i + 1 < args.size() else ""
		match args[i]:
			"--scene": scene_path = next
			"--out": _out = next
			"--frames": _frames = int(next)
			"--sizes":
				for s in next.split(","):
					var wh := s.split("x")
					_sizes.append(Vector2i(int(wh[0]), int(wh[1])))
	if _out.is_empty() or _sizes.is_empty():
		push_error("screen_capture: --out and --sizes are required")
		quit(1)
		return
	DirAccess.make_dir_recursive_absolute(_out)
	root.add_child((load(scene_path) as PackedScene).instantiate())
	_apply_size()


func _apply_size() -> void:
	root.size = _sizes[_index]
	_wait = _frames


func _process(_delta: float) -> bool:
	_wait -= 1
	if _wait > 0:
		return false
	var size := _sizes[_index]
	var image := root.get_texture().get_image()
	var path := _out.path_join("%dx%d.png" % [size.x, size.y])
	image.save_png(path)
	print("captured %s (%dx%d buffer)" % [path, image.get_width(), image.get_height()])
	_index += 1
	if _index >= _sizes.size():
		return true
	_apply_size()
	return false
