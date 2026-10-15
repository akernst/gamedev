extends RefCounted
## Base class for tests. Test files: res://tests/**/test_*.gd, methods named test_*.
## Optional hooks: before_each(), after_each().

var _failures: Array[String] = []


func assert_true(condition: bool, message: String = "") -> void:
	if not condition:
		_fail("expected true", message)


func assert_false(condition: bool, message: String = "") -> void:
	if condition:
		_fail("expected false", message)


func assert_eq(actual: Variant, expected: Variant, message: String = "") -> void:
	if typeof(actual) != typeof(expected) or actual != expected:
		_fail("expected %s, got %s" % [var_to_str(expected), var_to_str(actual)], message)


func assert_ne(actual: Variant, unexpected: Variant, message: String = "") -> void:
	if typeof(actual) == typeof(unexpected) and actual == unexpected:
		_fail("did not expect %s" % var_to_str(unexpected), message)


func assert_almost_eq(actual: float, expected: float, tolerance: float = 0.0001, message: String = "") -> void:
	if absf(actual - expected) > tolerance:
		_fail("expected %s ± %s, got %s" % [expected, tolerance, actual], message)


func assert_null(value: Variant, message: String = "") -> void:
	if value != null:
		_fail("expected null, got %s" % var_to_str(value), message)


func assert_not_null(value: Variant, message: String = "") -> void:
	if value == null:
		_fail("expected a value, got null", message)


func fail(message: String) -> void:
	_fail("failed", message)


func _fail(reason: String, message: String) -> void:
	_failures.append(reason if message.is_empty() else "%s: %s" % [message, reason])
