extends Node2D
class_name HealthComponent
@export var health = 100
@export var initial_health = 100
@export var max_health = 100
@export var team : Team.TEAM = Team.TEAM.PLAYER
var alive = true
var invincible_timer = Timer.new()
var invincible_duration = 1
var is_invincible = false

signal signal_dead
signal die_from_damage
signal signal_invincible
signal signal_vincible

func _ready() -> void:
	health = initial_health
	invincible_timer.one_shot = true
	invincible_timer.timeout.connect(_on_invincible_timer_timeout)
	add_child(invincible_timer)
	pass

func make_invincible(duration):
	invincible_timer.set_wait_time(duration)
	invincible_timer.start()
	is_invincible = true
	pass

func _on_invincible_timer_timeout() -> void:
	is_invincible = false
	pass


func damage(damage: int) -> void:
	if is_invincible:
		return
	health = max(health - damage, 0)
	if health <= 0:
		emit_signal("die_from_damage")
		die()
	pass

func heal(heal: int) -> void:
	health = min(health + heal, max_health)
	if health > 0:
		alive = true
	pass

func reset() -> void:
	health = initial_health
	alive = true
	pass

func die() -> void:
	alive = false
	emit_signal("signal_dead")
	pass
