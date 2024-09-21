extends State

@export var end_position : Node2D = null
@export var entity : Entity = null
@export var duration : float = 0
@export var speed = 100

var timer: Timer = null
var end_position_global = Vector2()
signal normal_entered

# Called when the node enters the scene tree for the first time.
func enter():
	if duration != 0:	
		timer = Timer.new()
		timer.wait_time = duration
		timer.one_shot = true
		timer.timeout.connect(die)
		add_child(timer)
	end_position_global = end_position.global_position
	emit_signal("normal_entered")
	pass

func process(delta):
	#move towards the end position
	var global_position = entity.global_position
	var direction = (end_position_global - global_position).normalized()
	entity.init_velocity = direction * speed
	if global_position.distance_to(end_position_global) < 16 and duration == 0:
		entity.health_component.die()
	pass


func die():
	entity.health_component.die()
	pass