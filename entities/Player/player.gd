extends CharacterBody2D

@export var speed = 200
@export var acceleration = 1000
@export var friction = 800
@onready var cannon : Cannon = $Cannon
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		cannon.shoot()
	pass

func _physics_process(delta: float) -> void:
	var direction = get_input_direction()
	if direction == Vector2.ZERO:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	else:
		velocity = velocity.move_toward(direction.normalized() * speed, acceleration * delta)
	move_and_slide()
	pass

func _input(event: InputEvent) -> void:
	pass

func get_input_direction() -> Vector2:
	var direction = Vector2.ZERO
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")

	return direction

func handle_shoot() -> void:
	pass