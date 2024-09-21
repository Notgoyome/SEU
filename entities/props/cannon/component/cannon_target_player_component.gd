extends Node2D

@export var cannon : Cannon

func _process(delta):
	var players = get_tree().get_nodes_in_group("player")
	if players.size() == 0:
		return
	var player = players[0]
	if player == null or player.is_queued_for_deletion() or player.died:
		return
	var direction = (player.global_position - cannon.global_position).normalized()
	cannon.cannon_direction = direction
