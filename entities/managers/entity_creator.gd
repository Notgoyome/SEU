extends Node2D

@export var entities_scene: Array[PackedScene] = []
@export var min_x: int = 0
@export var max_x: int = 630
@export var respawn_time: float = 1

var respawn_timer: Timer = null

func _ready() -> void:
    respawn_timer = Timer.new()
    add_child(respawn_timer)
    respawn_timer.set_wait_time(respawn_time)
    respawn_timer.set_one_shot(false)
    respawn_timer.timeout.connect(on_timer_timeout)
    respawn_timer.start()

func on_timer_timeout() -> void:
    var entity = entities_scene[randi() % entities_scene.size()].instantiate()
    entity.global_position = Vector2(randf_range(min_x, max_x), 0)
    get_tree().root.add_child(entity)
    pass