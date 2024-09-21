extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("reload"):
		TransitionGlobal.reload_scene()
	if Input.is_action_pressed("fasten"):
		Engine.time_scale = 2
	else:
		Engine.time_scale = 1
