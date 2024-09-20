extends Label

@export var player : Player = null
var health_component : HealthComponent = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_component = player.health_component
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if health_component:
		text = str(health_component.health) + "/" + str(health_component.max_health)
	pass
