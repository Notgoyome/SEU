extends CharacterBody2D
class_name Entity
var enable = false
@onready var health_component: HealthComponent = $HealthComponent
@onready var audio = $AudioStreamPlayer2D
@export var collision_shapes : Array[CollisionShape2D] = []
@export var acceleration = 200
@export var friction = 300
@export var score = 10

var init_velocity = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for shape in collision_shapes:
		shape.disabled = true
	enable = false
	hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !enable:
		return
	velocity = velocity.move_toward(init_velocity, acceleration * delta)
	move_and_slide()
	pass

func start():
	enable = true
	for shape in collision_shapes:
		shape.disabled = false
	show()
	pass

func _on_health_component_signal_dead() -> void:
	enable = false
	UserData.score += score
	queue_free()
	pass


func _on_health_component_die_from_damage() -> void:
	audio.reparent(get_tree().current_scene)
	audio.play()
	pass # Replace with function body.
