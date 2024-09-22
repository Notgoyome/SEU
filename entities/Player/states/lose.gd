extends State

@export var player: Player = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func enter() -> void:
	player.can_action = false
	player.hide()
	LevelGlobal.return_to_build()
	pass # Replace with function body.
