extends Node

var planes = {
	"light": {"sprite_frames":"res://entities/props/plane/sprite_frames/plane.tres",
			"speed": 200, "acceleration": 700, "friction":250, "health": 1},

	"medium": {"sprite_frames":"res://entities/props/plane/sprite_frames/plane.tres",
			"speed": 150, "acceleration": 500, "friction":500, "health": 2},
}

var cannons = {
	"medium" : {"bullet":"res://entities/bullet/bullet.tscn",
			"bullet_speed": 200, "bullet_cooldown": 0.1, "bullet_damage": 1, "bullet_pool_size": 50},
	"heavy" : {"bullet":"res://entities/bullet/bullet.tscn",
			"bullet_speed": 200, "bullet_cooldown": 0.5, "bullet_damage": 6, "bullet_pool_size": 10},
}


var selected_plane = "light"
var selected_cannon = "medium"

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func save_inventory() -> void:
	var save_file = FileAccess.open("user_data.gd", FileAccess.WRITE)

func load_inventory() -> void:
	var save_file = FileAccess.open("user_data.gd", FileAccess.READ)

func get_build():
	return [selected_plane, selected_cannon]