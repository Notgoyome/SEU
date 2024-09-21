extends Node

var transition_scene = preload("res://ui/transition_scene/transition_scene.tscn")
var transition_scene_instance = null
var animation_player : AnimationPlayer= null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    transition_scene_instance = transition_scene.instantiate()
    animation_player = transition_scene_instance.get_node("AnimationPlayer")
    add_child(transition_scene_instance)    
    pass

func _process(delta: float) -> void:
    pass    

func change_scene(scene_path: String = "", reload = false) -> void:
    animation_player.play("start")
    
    await animation_player.animation_finished
    if reload:
        get_tree().reload_current_scene()
    else:
        get_tree().change_scene_to_file(scene_path)
    await get_tree().process_frame

    animation_player.play("end")



func reload_scene() -> void:
    change_scene("", true)
    pass