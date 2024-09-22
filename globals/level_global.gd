extends Node

# var levels = [
# 	"res://scenes/level/level0.tscn",
# 	"res://scenes/level/level2.tscn",
# 	"res://scenes/level/level3.tscn"
# ]

var levels = {
	0 : {"scene": "res://scenes/level/level0.tscn", "music" : "res://level_music/Mercury.wav"},
	1 : {"scene": "res://scenes/level/level2.tscn", "music" : "res://level_music/Mercury.wav"},
	2 : {"scene": "res://scenes/level/level3.tscn", "music" : "res://level_music/BossMain.wav"},
	
}

var build_scene = "res://menus/build.tscn"

var selected_level = 0
var player: Player = null
var win = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func win_level() -> void:
	win =  true
	player = get_tree().get_nodes_in_group("player")[0]
	if player != null:
		player.state_win()

func launch_next_level(wait_time) -> void:
	print("launch_next_level")
	if wait_time > 0:
		await get_tree().create_timer(wait_time).timeout

	if selected_level == levels.size() - 1:
		return_to_build()
		return
	selected_level = selected_level + 1
	launch_level()

func launch_level() -> void:
	win = false
	await TransitionGlobal.change_scene(levels[selected_level]["scene"])
	var list = get_tree().get_nodes_in_group("player")
	if list.size() == 0:
		assert(false, "No player found, make sure to add the right level scene")
	player = get_tree().get_nodes_in_group("player")[0]
	
func start() -> void:
	UserData.score = 0
	selected_level = 0
	UserData.build(true)
	launch_level()
	pass

func return_to_build() -> void:
	TransitionGlobal.change_scene(build_scene)
	pass

