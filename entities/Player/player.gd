extends CharacterBody2D
class_name Player
var speed = 0
var acceleration = 0
var friction = 0
var delta_y

var team = Team.TEAM.PLAYER
@export var cannon: Cannon = null
@export var plane: AirPlane = null
@onready var health_component: HealthComponent = $HealthComponent
func _ready() -> void:
	cannon.team = Team.TEAM.PLAYER
	setup_plane(plane)
	pass

# STATE

var can_action = true

func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot") and can_action:
		cannon.handle_shoot()
	pass

func _physics_process(delta: float) -> void:
	var direction = get_input_direction()
	if can_action:
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


func setup_plane(plane) -> void:
	speed = plane.speed
	acceleration = plane.acceleration
	friction = plane.friction
	health_component.max_health = plane.health
	pass