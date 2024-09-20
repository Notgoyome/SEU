extends Label

@export var text_inventory = "gold"
var value = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	value = UserData.inventory[text_inventory]
	text = str(value)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
