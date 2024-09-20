extends CharacterBody2D
class_name Entity
@export var delta_y = 0
@export var speed = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if delta_y > 0:
		velocity.y = speed * delta
		delta_y -= speed * delta
	move_and_slide()
	pass
