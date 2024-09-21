extends CharacterBody2D
class_name Bullet
@export var movement_component: MovementComponent = null
@export var active: bool = false

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var collision_shape_area : CollisionShape2D = $Area2D/CollisionShape2D
@export var bounce_step = 0
var bounce_index = 0
var speed = 0
var damage = 0
var cannon_direction = Vector2(0, 1)
var team_type = Team.TEAM.PLAYER
var die_next_turn = false
func _ready() -> void:
	disable()
	pass


func _process(delta: float) -> void:
	if !active:
		return

	velocity = movement_component.get_velocity(cannon_direction) * delta * speed
	rotate(movement_component.get_rotation_value() * delta)
	move_and_slide()
	if FunctionGlobal.is_outside_camera_view(global_position):
		if bounce_index == bounce_step:
			disable()
			return
		else:
			bounce_index += 1
			movement_component.bounce(cannon_direction) #PIN TO DO
	
	pass

func disable() -> void:
	active = false
	sprite.hide()
	collision_shape.disabled = true
	collision_shape_area.disabled = true
	pass

func shoot(init_global_position: Vector2,
			team,
			init_speed = speed,
			init_damage = damage,
			init_direction = Vector2(0,1),) -> void:
	bounce_index = 0
	global_position = init_global_position
	team_type = team
	speed = init_speed
	damage = init_damage
	cannon_direction = init_direction
	active = true
	sprite.show()
	collision_shape.disabled = false
	collision_shape_area.disabled = false
	pass


func _on_area_2d_body_entered(body:Node2D) -> void:
	if collision_shape_area.disabled:
		return
	if body.has_node("HealthComponent") and body.get_node("HealthComponent").team != team_type:
		body.get_node("HealthComponent").damage(damage)
		disable()
	pass # Replace with function body.