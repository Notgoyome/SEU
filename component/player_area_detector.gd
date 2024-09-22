extends Area2D

signal body_type_entered
var list_actions = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is Action:
			list_actions.append(child)
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body:Node2D) -> void:
	if body.is_in_group("player"):
		emit_signal("body_type_entered")
		for action in list_actions:
			action.action()
	pass # Replace with function body.
