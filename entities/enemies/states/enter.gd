extends State

@export var start_position : Node = null
@export var entity : Entity = null
# @export var duration : float = 0.1
@export var speed = 100
@export var finished_state = "normal"
var end_position : Vector2 = Vector2(0, 0)
var tween : Tween = null
var action : bool = false

func _ready() -> void:
	tween = create_tween()
	pass
# Called when the node enters the scene tree for the first time.
func enter() -> void:
	end_position = entity.global_position
	entity.global_position = start_position.global_position
	pass

func process(delta: float) -> void:
	var global_position = entity.global_position
	var direction = (end_position - global_position).normalized()
	entity.init_velocity = direction * speed
	
	if global_position.distance_to(end_position) < 16:
		emit_signal("state_finished", self, finished_state)
	pass
