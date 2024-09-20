extends State

@export var player: Player = null
var old_collision_layer: int
var old_collision_mask: int
@export var delta_y = -64
@export var duration = 0.4
var tween: Tween = create_tween()

func enter() -> void:
	player.can_action = false
	old_collision_layer = player.collision_layer
	old_collision_mask = player.collision_mask
	player.collision_layer = 0
	player.collision_mask = 0
	var new_position = Vector2(player.position.x, player.position.y + delta_y)
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