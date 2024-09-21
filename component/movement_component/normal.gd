extends MovementComponent

@export var auto_rotate: bool = false
@export var rotation_speed: float = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_velocity(vector) -> Vector2:
	return vector

func get_rotation_value() -> float:
	if auto_rotate:
		return rotation_speed
	return 0.0

func bounce(vector) -> void:
	var new_vector = Vector2(-vector.x, vector.y)
	pass