extends MovementComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_velocity(vector) -> Vector2:
	return velocity

func get_rotation_value() -> float:
	return rotation_value
