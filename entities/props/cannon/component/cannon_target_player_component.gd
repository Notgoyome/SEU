extends Node2D

@export var cannon : Cannon
@export var disabled = false
func _process(delta):
	if cannon == null or cannon.is_queued_for_deletion() or disabled:
		return
	var players = get_tree().get_nodes_in_group("player")
	if players.size() == 0:
		return
	var player = players[0]
	if player == null or player.is_queued_for_deletion() or player.died:
		return
	var direction = (player.global_position - cannon.global_position).normalized()
	cannon.cannon_direction = direction
