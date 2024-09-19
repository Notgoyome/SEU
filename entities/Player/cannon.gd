extends Node2D
class_name Cannon
@export var fire_rate : float = 0.5
@export var max_fire_rate : float = 0.25
@export var bullet_speed = 8000
@export var timeout_bullet : float = 2

@export var bullet_scene : PackedScene


var bullet_list : Array[Bullet] = []
var bullet_max : int = int(timeout_bullet / max_fire_rate + 1)
var bullet_index : int = 0

var rate_timer : Timer
var can_fire : bool = true

func _ready() -> void:
    init_timer()
    if bullet_scene == null:
        return
    for i in range(bullet_max):
        var bullet : Bullet = bullet_scene.instantiate()
        bullet.timeout = timeout_bullet
        bullet_list.append(bullet)
        bullet.speed = bullet_speed
        bullet.position = global_position
        get_tree().root.call_deferred("add_child", bullet)
    pass

func shoot() -> void:
    if bullet_list.size() == 0 or !can_fire:
        return

    bullet_list[bullet_index].activate(global_position)
    bullet_index = (bullet_index + 1) % bullet_max
    can_fire = false
    rate_timer.start()

func _on_rate_timer_timeout() -> void:
    can_fire = true
    pass

func init_timer() -> void:
    rate_timer = Timer.new()
    rate_timer.set_wait_time(fire_rate)
    rate_timer.set_one_shot(false)
    rate_timer.timeout.connect(_on_rate_timer_timeout)
    add_child(rate_timer)
    rate_timer.start()