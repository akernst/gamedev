extends SceneTree
## Loads a scene, runs it for N frames and prints a JSON performance summary.
## Usage: godot --path game -s res://tests/support/perf_probe.gd -- --scene res://scenes/main.tscn --frames 600

var _frames := 600
var _count := 0
var _process_ms: Array[float] = []


func _initialize() -> void:
	var args := OS.get_cmdline_user_args()
	var scene_path := "res://scenes/main.tscn"
	for i in args.size():
		if args[i] == "--scene" and i + 1 < args.size():
			scene_path = args[i + 1]
		elif args[i] == "--frames" and i + 1 < args.size():
			_frames = int(args[i + 1])
	var packed: PackedScene = load(scene_path)
	if packed == null:
		push_error("perf_probe: cannot load %s" % scene_path)
		quit(1)
		return
	root.add_child(packed.instantiate())


func _process(_delta: float) -> bool:
	_count += 1
	if _count > 10:  # skip warm-up frames
		_process_ms.append(Performance.get_monitor(Performance.TIME_PROCESS) * 1000.0)
	if _count >= _frames + 10:
		_report()
		return true
	return false


func _report() -> void:
	var total := 0.0
	var worst := 0.0
	for v in _process_ms:
		total += v
		worst = maxf(worst, v)
	var summary := {
		"frames": _process_ms.size(),
		"process_ms_avg": snappedf(total / maxf(1.0, _process_ms.size()), 0.001),
		"process_ms_worst": snappedf(worst, 0.001),
		"static_memory_mb": snappedf(Performance.get_monitor(Performance.MEMORY_STATIC) / 1048576.0, 0.01),
		"objects": int(Performance.get_monitor(Performance.OBJECT_COUNT)),
		"nodes": int(Performance.get_monitor(Performance.OBJECT_NODE_COUNT)),
		"draw_calls": int(Performance.get_monitor(Performance.RENDER_TOTAL_DRAW_CALLS_IN_FRAME)),
	}
	print(JSON.stringify(summary))
