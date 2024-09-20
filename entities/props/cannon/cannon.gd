extends Node2D
class_name Cannon
@export var cannon_direction: Vector2 = Vector2(0, -1)
@export var auto_fire: bool = false

@export_group("Bullet")
@export var bullet_scene: PackedScene = null
@export var bullet_speed: float = 200
@export var bullet_cooldown: float = 0.1
@export var bullet_damage: int = 1
@export var bullet_pool_size: int = 50

var bullet_list: Array[Bullet] = []
var bullet_index = 0
var bullet_timer : Timer = null
var can_shot = true

@export var team : Team.TEAM = Team.TEAM.PLAYER

func _ready() -> void:
	bullet_speed *= 1000
	for i in range(bullet_pool_size):
		var bullet = bullet_scene.instantiate()
		get_tree().root.call_deferred("add_child", bullet)
		bullet_list.append(bullet)
	bullet_timer = Timer.new()
	add_child(bullet_timer)
	bullet_timer.set_wait_time(bullet_cooldown)
	bullet_timer.set_one_shot(false)
	bullet_timer.timeout.connect(on_timer_timeout)
	if auto_fire:
		bullet_timer.start()

func _process(delta: float) -> void:
	pass

func handle_shoot() -> void:
	if can_shot:
		bullet_list[bullet_index].shoot(global_position,
										team,
										bullet_speed,
										bullet_damage,
										cannon_direction,
										)
		bullet_index = (bullet_index + 1) % bullet_pool_size
		can_shot = false
		bullet_timer.start()

func on_timer_timeout() -> void:
	can_shot = true
	if auto_fire:
		handle_shoot()