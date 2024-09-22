extends State

@export var entity : Entity = null
@export var speed = 50

var x_min = 64
var x_max = 256
var gap = 16
var direction = 1
var timer = Timer.new()

signal on_normal_entered
signal on_normal_exited

func _ready():
	timer.set_wait_time(5)
	timer.set_one_shot(true)
	timer.timeout.connect(change_state)
	add_child(timer)
	pass

func enter():
	timer.start()
	emit_signal("on_normal_entered")
	pass

func exit():
	emit_signal("on_normal_exited")
	pass

func process(delta):
	entity.init_velocity = Vector2(speed * direction, 0)
	if entity.global_position.x < x_min + gap: 
		direction = 1
	elif entity.global_position.x > x_max - gap:
		direction = -1
	pass

func change_state():
	emit_signal("state_finished", self, "phase2")
	pass