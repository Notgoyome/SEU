extends CPUParticles2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_health_component_die_from_damage() -> void:
	emitting = true
	reparent(get_tree().current_scene)
	pass # Replace with function body.
