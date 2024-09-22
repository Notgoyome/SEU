extends Node
# Typing for dictionaries with PackedScene objects
var planes: Dictionary = {
	"light": preload("res://entities/props/plane/plane_light.tscn") as PackedScene,
	"medium": preload("res://entities/props/plane/plane_medium.tscn") as PackedScene,
	"heavy": preload("res://entities/props/plane/plane_heavy.tscn") as PackedScene,
}

var cannons: Dictionary = {
	"light": preload("res://entities/props/cannon/ally_component/ally_cannon_light.tscn") as PackedScene,
	"medium": preload("res://entities/props/cannon/ally_component/cannon_wave.tscn") as PackedScene,
	"heavy": preload("res://entities/props/cannon/ally_component/ally_cannon_slow.tscn") as PackedScene,
}

var characters: Dictionary = {
	"light": {
		"name": "bolt",
		"type": "light",
		"plane": planes["light"] as PackedScene,
		"cannon": cannons["light"] as PackedScene,
		"block_theme": "res://assets/character_cube/yellow.png",
	},
	"medium": {
		"name": "cyan",
		"type": "medium",
		"plane": planes["medium"] as PackedScene,
		"cannon": cannons["medium"] as PackedScene,
		"block_theme": "res://assets/character_cube/blue.png",
	},
	"heavy": {
		"name": "diesel",
		"type": "heavy",
		"plane": planes["heavy"] as PackedScene,
		"cannon": cannons["heavy"] as PackedScene,
		"block_theme": "res://assets/character_cube/green.png",
	}
}

var inventory: Dictionary = {
	1: {
		"type": "character",
		"character": characters["light"] as Dictionary
	},
	2: {
		"type": "character",
		"character": characters["medium"] as Dictionary
	},
	3: {
		"type": "character",
		"character": characters["heavy"] as Dictionary
	}
}
signal on_next_character

var score: int = 0
var selected_character: Array = [characters["light"],characters["medium"],  characters["heavy"]]
var selected_plane_list: Array[Node] = []
var selected_cannon_list: Array[Cannon] = []
var index_list = 0

func _ready() -> void:
	build(true)
	pass

func build(start = false) -> Array:
	if start:
		index_list = 0
	reset_build()
	for character in selected_character:
		var plane_scene = character["plane"]
		if plane_scene:
			var plane = plane_scene.instantiate()
			selected_plane_list.append(plane)
		
		var cannon_scene = character["cannon"]
		if cannon_scene:
			var cannon = cannon_scene.instantiate()
			selected_cannon_list.append(cannon)
	return [selected_plane_list, selected_cannon_list]

func reset_build() -> void:
	for plane in selected_plane_list:
		if plane != null:
			plane.queue_free()

	for cannon in selected_cannon_list:
		if cannon != null:
			cannon.queue_free()
	
	selected_plane_list = []
	selected_cannon_list = []


func next_character():
	index_list += 1
	if index_list >= selected_plane_list.size():
		return null
	return get_character()

func get_character():
	if index_list >= selected_plane_list.size():
		return null
	return [selected_plane_list[index_list], selected_cannon_list[index_list]]

func _process(delta: float) -> void:
	pass

func save_inventory() -> void:
	var save_file = FileAccess.open("user_data.gd", FileAccess.WRITE)

func load_inventory() -> void:
	var save_file = FileAccess.open("user_data.gd", FileAccess.READ)
