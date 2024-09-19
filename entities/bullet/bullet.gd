extends CharacterBody2D
class_name Bullet
var active = false
var timeout : float = 2
var timeout_timer : Timer
var speed : float = 500
var direction = -1

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@export var movement_component : MovementComponent
@onready var audio : AudioStreamPlayer2D = $AudioStreamPlayer2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if movement_component == null:
		assert(false, "Movement component is not set")
	sprite.hide()
	timeout_timer = Timer.new()
	timeout_timer.set_wait_time(timeout)
	timeout_timer.set_one_shot(true)
	timeout_timer.timeout.connect(_on_timeout_timer_timeout)
	add_child(timeout_timer)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !active:
		return
	var delta_position = movement_component.get_velocity() * speed * delta * direction
	print(movement_component.get_velocity())
	velocity = delta_position
	move_and_slide()
	pass

func activate(global_position) -> void:
	sprite.show()
	active = true
	timeout_timer.start()
	position = global_position
	audio.play()
	pass

func die() -> void:
	sprite.hide()
	active = false
	pass

func _on_timeout_timer_timeout() -> void:
	die()
	pass
