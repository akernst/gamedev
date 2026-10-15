extends SceneTree
## Headless test runner. Usage: godot --headless --path game -s res://tests/runner.gd -- [path filter]
## Exits with 0 when every test passes, 1 otherwise. Engine errors raised during a test fail that test.

const TEST_ROOT := "res://tests"


class ErrorCounter:
	extends Logger
	var count := 0
	var messages: Array[String] = []

	func _log_error(function: String, file: String, line: int, code: String, rationale: String, _editor_notify: bool, error_type: int, _script_backtrace: Array[ScriptBacktrace]) -> void:
		# error_type 3 is ERROR_TYPE_WARNING in this Logger callback; ignore warnings, count errors.
		if error_type == 3:
			return
		count += 1
		var text := rationale if not rationale.is_empty() else code
		messages.append("%s (%s:%d in %s)" % [text, file, line, function])

	func _log_message(_message: String, _error: bool) -> void:
		pass


func _initialize() -> void:
	var args := OS.get_cmdline_user_args()
	var filter: String = args[0] if args.size() > 0 else ""
	var files: Array[String] = []
	_collect(TEST_ROOT, files)
	files.sort()

	var errors := ErrorCounter.new()
	OS.add_logger(errors)

	var passed := 0
	var failed := 0
	for path in files:
		if not filter.is_empty() and not path.contains(filter):
			continue
		var script: GDScript = load(path)
		if script == null or not script.can_instantiate():
			print("FAIL %s: could not load test script" % path)
			failed += 1
			continue
		for method in script.get_script_method_list():
			var name: String = method["name"]
			if not name.begins_with("test_"):
				continue
			var case: Object = script.new()
			var errors_before := errors.count
			if case.has_method("before_each"):
				case.call("before_each")
			case.call(name)
			if case.has_method("after_each"):
				case.call("after_each")
			var failures: Array[String] = case.get("_failures")
			for i in range(errors_before, errors.count):
				failures.append("engine error: " + errors.messages[i])
			if failures.is_empty():
				passed += 1
			else:
				failed += 1
				for f in failures:
					print("FAIL %s::%s: %s" % [path, name, f])

	OS.remove_logger(errors)
	print("RESULT: %d passed, %d failed" % [passed, failed])
	quit(0 if failed == 0 and passed > 0 else 1)


func _collect(dir_path: String, out: Array[String]) -> void:
	var dir := DirAccess.open(dir_path)
	if dir == null:
		return
	for sub in dir.get_directories():
		_collect(dir_path.path_join(sub), out)
	for file in dir.get_files():
		if file.begins_with("test_") and file.ends_with(".gd"):
			out.append(dir_path.path_join(file))
