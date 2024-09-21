extends State

@export var player: Player = null
var old_collision_layer: int
var old_collision_mask: int
@export var delta_y = -64
@export var duration = 0.4
var initial_position: Vector2
var tween: Tween = null

func _ready() -> void:
	initial_position = player.position
	pass

func enter() -> void:
	player.velocity = Vector2()
	player.position = initial_position
	var player_health_component : HealthComponent = player.get_node("HealthComponent")
	player_health_component.reset()
	player_health_component.make_invincible(duration * 2)
	player.can_action = false
	old_collision_layer = player.collision_layer
	old_collision_mask = player.collision_mask
	player.collision_layer = 0
	player.collision_mask = 0
	var new_position = Vector2(player.position.x, player.position.y + delta_y)
	tween = create_tween()
	tween.tween_property(player, "position",new_position, duration).set_trans(Tween.TRANS_QUAD)
	pass

func process(delta: float) -> void:
	if not tween.is_running():
		emit_signal("state_finished", self, "normal")
		return
	pass

func physic_process(delta: float) -> void:
	pass

func exit() -> void:
	player.can_action = true
	player.collision_layer = old_collision_layer
	player.collision_mask = old_collision_mask
	pass
