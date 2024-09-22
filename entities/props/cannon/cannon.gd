extends Node2D
class_name Cannon
@export var cannon_direction: Vector2 = Vector2(0, -1)
@export var auto_fire: bool = false

@export_group("Bullet")
@export var bullet_scene: PackedScene = null
@export var bullet_speed: float = 200
@export var bullet_cooldown: float = 0.1
@export var bullet_damage: int = 1
@export_group("bullet_aoe")
@export var bullet_num: int = 1
@export_range(0, 360, 1) var bullet_angle: int = 0
@export_range(0,360,1) var angle_offset_per_shot: int = 0

@export var bullet_pool_size: int = 50
@export var can_shoot = true

var bullet_list: Array[Bullet] = []
var bullet_index = 0
var bullet_timer : Timer = null

signal _on_shoot()

@export var team : Team.TEAM = Team.TEAM.PLAYER

func _ready() -> void:
	bullet_speed *= 1000
	for i in range(bullet_pool_size):
		var bullet = bullet_scene.instantiate()
		get_tree().current_scene.call_deferred("add_child", bullet)
		bullet_list.append(bullet)
	bullet_timer = Timer.new()
	add_child(bullet_timer)
	bullet_timer.set_wait_time(bullet_cooldown)
	bullet_timer.set_one_shot(false)
	bullet_timer.timeout.connect(on_timer_timeout)
	if auto_fire and can_shoot:
		bullet_timer.start()

func _process(delta: float) -> void:
	pass

func handle_shoot() -> void:
	if can_shoot:
		if bullet_list[bullet_index] == null:
			return
		emit_signal("_on_shoot")
		for i in range(bullet_num):
			var new_direction = cannon_direction
			if (bullet_angle != 0):
				new_direction = get_direction(bullet_num, bullet_angle, i)
	
			bullet_list[bullet_index].shoot(global_position,
										team,
										bullet_speed,
										bullet_damage,
										new_direction,
										)
			bullet_index = (bullet_index + 1) % bullet_pool_size
		can_shoot = false
		bullet_timer.start()
		cannon_direction = cannon_direction.rotated(deg_to_rad(angle_offset_per_shot))

func get_direction(num: int, angle: int, index: int) -> Vector2:
	var direction = cannon_direction
	var half_angle = float(angle) / 2
	var start_angle : float = -half_angle
	print("start_angle", start_angle)
	print("start_angle", start_angle)
	var new_angle = start_angle + float(angle) / (num - 1) * index
	print("new_angle", new_angle)
	direction = direction.rotated(deg_to_rad(new_angle))
	print("========================")

	return direction
	


func on_timer_timeout() -> void:
	can_shoot = true
	if auto_fire:
		handle_shoot()

func _on_normal_normal_entered() -> void:
	bullet_timer.start()
	can_shoot = true
	pass

func _on_normal_normal_exited() -> void:
	bullet_timer.stop()
	can_shoot = false
	pass

func _on_health_component_signal_dead() -> void:
	for bullet in bullet_list:
		bullet.die_next_turn = true
	pass # Replace with function body.
