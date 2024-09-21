extends State

var is_normal = false
@export var player: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func enter() -> void:
	is_normal = true
	pass # Replace with function body.

func _on_health_component_signal_dead() -> void:
	if !is_normal:
		return
	player.consume()
	if player.died:
		emit_signal("state_finished", self, "died")
		return
	emit_signal("state_finished", self, "Scene")
	pass # Replace with function body.

func exit() -> void:
	is_normal = false
	pass # Replace with function body.
	
