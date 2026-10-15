class_name NumberFormat
extends RefCounted
## Formats large numbers for display: 999 -> "999", 1234 -> "1.23K", 1.5e15 -> "1.50Qa".
## Beyond the named suffixes it falls back to scientific notation ("1.00e42").

const SUFFIXES: Array[String] = ["", "K", "M", "B", "T", "Qa", "Qi", "Sx", "Sp", "Oc", "No", "Dc"]


static func short(value: float, decimals: int = 2) -> String:
	if is_nan(value):
		return "NaN"
	var sign_str := "-" if value < 0.0 else ""
	var v := absf(value)
	if v < 1000.0:
		return sign_str + str(int(floor(v)))
	var tier := int(floor(log(v) / log(1000.0)))
	# Guard against float rounding at exact powers of 1000.
	if pow(1000.0, tier) > v:
		tier -= 1
	if tier >= SUFFIXES.size():
		var exponent := int(floor(log(v) / log(10.0)))
		var mantissa := v / pow(10.0, exponent)
		return "%s%.*fe%d" % [sign_str, decimals, mantissa, exponent]
	var scaled := v / pow(1000.0, tier)
	# Rounding can produce 1000.00K; promote to the next suffix.
	if snappedf(scaled, pow(10.0, -decimals)) >= 1000.0 and tier + 1 < SUFFIXES.size():
		tier += 1
		scaled = v / pow(1000.0, tier)
	return "%s%.*f%s" % [sign_str, decimals, scaled, SUFFIXES[tier]]
