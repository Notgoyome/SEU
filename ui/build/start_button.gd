extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	pass # Replace with function body.


func _on_button_up() -> void:
	var color = "ffffff"
	modulate = Color(color)
	LevelGlobal.launch_level()
	pass # Replace with function body.


func _on_button_down() -> void:
	var color = "7e7eab"
	modulate = Color(color)
	pass # Replace with function body.
