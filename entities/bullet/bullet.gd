extends CharacterBody2D
class_name Bullet
@export var movement_component: MovementComponent = null
@export var active: bool = false

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

var speed = 0
var damage = 0
var cannon_direction = Vector2(0, 1)
var team_type = Team.TEAM.PLAYER

func _ready() -> void:
	disable()
	pass


func _process(delta: float) -> void:
	if active:
		# position += movement_component.get_velocity() * delta * speed * cannon_direction
		velocity = movement_component.get_velocity() * delta * speed * cannon_direction
		move_and_slide()
	if is_outside_camera_view():
		disable()
	pass

func disable() -> void:
	active = false
	sprite.hide()
	collision_shape.disabled = true
	pass

func shoot(init_global_position: Vector2,
			team,
			init_speed = speed,
			init_damage = damage,
			init_direction = Vector2(0,1),) -> void:

	global_position = init_global_position
	team_type = team
	speed = init_speed
	damage = init_damage
	cannon_direction = init_direction
	active = true
	sprite.show()
	collision_shape.disabled = false
	pass

func is_outside_camera_view():
	var camera = get_viewport().get_camera_2d()
	var camera_rect = null
	var object_position = global_position

	if camera != null:
		camera_rect = Rect2(camera.global_position - camera.zoom * camera.get_screen_size() / 2, camera.zoom * camera.get_screen_size())
	else:
		camera_rect = Rect2(Vector2(), Vector2(get_viewport().get_visible_rect().size))
	return not camera_rect.has_point(object_position)


func _on_area_2d_body_entered(body:Node2D) -> void:
	if body.has_node("HealthComponent") and body.get_node("HealthComponent").team != team_type:
		body.get_node("HealthComponent").damage(damage)
		disable()
	pass # Replace with function body.
