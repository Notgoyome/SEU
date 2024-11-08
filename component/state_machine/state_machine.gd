extends Node
class_name StateMachine
@export var initial_state : State

var states : Dictionary = {}
var current_state : State

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.state_finished.connect(on_state_transition)
	
	if initial_state:
		current_state = initial_state
		current_state.enter()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_state:
		current_state.process(delta)
	pass

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physic_process(delta)

func change_state(new_state_name: String) -> void:
	var current_state_name = states.get(current_state.name.to_lower())
	on_state_transition(current_state, new_state_name)

func on_state_transition(state: State, new_state_name: String) -> void:
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	if current_state:
		current_state.exit()
	new_state.enter()
	current_state = new_state
	pass
