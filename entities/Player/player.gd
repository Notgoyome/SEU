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
func _ready() -> void:
	consume()
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


func consume() -> void:
	if not built:
		var build = UserData.build()
		selected_plane_list = build[0]
		selected_cannon_list = build[1]
		built = true
	var plane_temp = selected_plane_list.pop_front()
	var cannon_temp = selected_cannon_list.pop_front()
	
	if plane_temp == null or cannon_temp == null:
		died = true
		return
	print("building")
	plane = plane_temp
	add_child(plane)
	cannon = cannon_temp
	add_child(cannon)
	cannon.team = Team.TEAM.PLAYER
	pass