extends Control
## Placeholder main scene. The first feature replaces it.


func _ready() -> void:
	$Label.text = "Ready: %s" % NumberFormat.short(1234567.0)
