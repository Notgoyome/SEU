extends Node

var planes = {
	"light": "res://entities/props/plane/plane_light.tscn",
	"medium": "res://entities/props/plane/plane_medium.tscn",
}

var cannons = {
	"light" : "res://entities/props/cannon/ally_component/ally_cannon_light.tscn",
	"heavy" : "res://entities/props/cannon/ally_component/cannon_wave.tscn"
}

var score = 0
var selected_plane_list_string = ["light", "medium", "light"]
var selected_cannon_list_string = ["heavy", "light", "light"]

func _ready() -> void:
	pass

func build():
	var selected_plane_list = []
	var selected_cannon_list : Array[Cannon] = []

	for plane in selected_plane_list:
		if plane != null:
			plane.queue_free()
	for cannon in selected_cannon_list:
		if cannon != null:
			cannon.queue_free()
	for plane_string in selected_plane_list_string:
		var plane_scene = load(planes[plane_string])
		var plane = plane_scene.instantiate()
		selected_plane_list.append(plane)
	for cannon_string in selected_cannon_list_string:
		var cannon_scene = load(cannons[cannon_string])
		var cannon = cannon_scene.instantiate()
		selected_cannon_list.append(cannon)
	return [selected_plane_list, selected_cannon_list]

func _process(delta: float) -> void:
	pass

func save_inventory() -> void:
	var save_file = FileAccess.open("user_data.gd", FileAccess.WRITE)

func load_inventory() -> void:
	var save_file = FileAccess.open("user_data.gd", FileAccess.READ)
