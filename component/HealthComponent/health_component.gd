extends Node2D
class_name HealthComponent
@export var health = 100
@export var initial_health = 100
@export var max_health = 100
@export var team : Team.TEAM = Team.TEAM.PLAYER
var alive = true

func damage(damage: int) -> void:
    health = max(health - damage, 0)
    if health <= 0:
        die()
    pass

func heal(heal: int) -> void:
    health = min(health + heal, max_health)
    if health > 0:
        alive = true
    pass

func die() -> void:
    alive = false
    pass