extends Node
class_name MovementComponent

@export var velocity: Vector2 = Vector2()
@export var rotation_value: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_velocity() -> Vector2:
	return Vector2()

func get_rotation_value() -> float:
	return 0.0