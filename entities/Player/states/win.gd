extends State

@export var player: Player = null
var old_collision_layer: int
var old_collision_mask: int
var initial_position: Vector2
var end_position : Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initial_position = player.global_position
	print(initial_position)
	pass # Replace with function body.

func enter() -> void:
	var player_health_component : HealthComponent = player.get_node("HealthComponent")
	# player_health_component.make_invincible(2.0) useless
	player.can_action = false
	old_collision_layer = player.collision_layer
	old_collision_mask = player.collision_mask
	player.collision_layer = 4
	player.collision_mask = 4
	end_position = Vector2(initial_position.x, -32)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(delta: float) -> void:
	var direction = Vector2(end_position.x - player.global_position.x, end_position.y - player.global_position.y).normalized()
	player.velocity = player.velocity.move_toward(direction * player.plane.speed,
													player.plane.acceleration * delta)
	if player.position.distance_to(end_position) < 8:
		LevelGlobal.launch_next_level(0)
		emit_signal("state_finished", self, "normal")
		return
	pass
