extends "res://tests/test_case.gd"


func test_small_numbers_are_whole() -> void:
	assert_eq(NumberFormat.short(0.0), "0")
	assert_eq(NumberFormat.short(999.9), "999")


func test_thousands_and_millions() -> void:
	assert_eq(NumberFormat.short(1234.0), "1.23K")
	assert_eq(NumberFormat.short(1234567.0), "1.23M")


func test_exact_powers_of_thousand() -> void:
	assert_eq(NumberFormat.short(1000.0), "1.00K")
	assert_eq(NumberFormat.short(1e12), "1.00T")


func test_rounding_promotes_suffix() -> void:
	assert_eq(NumberFormat.short(999999.0), "1.00M")


func test_negative_numbers() -> void:
	assert_eq(NumberFormat.short(-1500.0), "-1.50K")


func test_scientific_beyond_suffixes() -> void:
	assert_eq(NumberFormat.short(1e40), "1.00e40")
