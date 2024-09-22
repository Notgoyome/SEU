extends CharacterBody2D
class_name Player
var delta_y

var team = Team.TEAM.PLAYER

@export var cannon: Cannon = null
@export var plane: AirPlane = null
@onready var health_component: HealthComponent = $HealthComponent
var selected_plane_list: Array = []
var selected_cannon_list: Array[Cannon] = []
var died = false
var built = false

@onready var state_machine: StateMachine = $StateMachine

func _ready() -> void:
	UserData.build()
	set_character()
	pass

# STATE

var can_action = true

func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot") and can_action:
		cannon.handle_shoot()
	pass

func _physics_process(delta: float) -> void:
	var direction = get_input_direction()
	if can_action and plane != null:
		if direction == Vector2.ZERO:
			velocity = velocity.move_toward(Vector2.ZERO, plane.friction * delta)
		else:
			velocity = velocity.move_toward(direction.normalized() * plane.speed, plane.acceleration * delta)
	move_and_slide()
	pass

func get_input_direction() -> Vector2:
	var direction = Vector2.ZERO
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")

	return direction

func set_character():
	var character = UserData.get_character()
	if character == null:
		died = true
		return false
	var plane_temp = character[0]
	var cannon_temp = character[1]

	plane = plane_temp
	add_child(plane)
	cannon = cannon_temp
	add_child(cannon)
	cannon.team = Team.TEAM.PLAYER
	return true


func state_win() -> void:
	if died:
		return
	state_machine.change_state("win")
	pass # Replace with function body.
