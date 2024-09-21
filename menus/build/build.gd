extends Node2D

@export var grid_container: GridContainer = null
@export var item_panel: PackedScene = null
@export var squad_selection_container : VBoxContainer = null
@export var squad_selection_item : PackedScene = null

func _ready() -> void:
    add_icon_to_squad_selection()
    pass


func get_characters_animated_sprite() -> Array:
    var list_sprite = []
    for character in UserData.selected_character:
        var plane = character["plane"]
        var instance = plane.instantiate()
        var plane_animated_sprite : AnimatedSprite2D = instance.get_node("AnimatedSprite2D")
        list_sprite.append(plane_animated_sprite)
    return list_sprite

func add_icon_to_squad_selection():
    var list_sprite = get_characters_animated_sprite()
    for i in range(UserData.selected_character.size()):
        var item_panel_instance = squad_selection_item.instantiate()

        change_sprite_frame(item_panel_instance.get_node("AnimatedSprite2D"), list_sprite[i])
        change_label_text(item_panel_instance.get_node("Label"), UserData.selected_character[i])

        squad_selection_container.add_child(item_panel_instance)
pass

func change_label_text(label: Label, character: Dictionary):
    label.text = character["name"] + "\n" + "Type: " + character["type"]
    pass

func change_sprite_frame(sprite: AnimatedSprite2D, sprite2: AnimatedSprite2D):
    sprite.sprite_frames = sprite2.sprite_frames
    pass

func add_icon_to_list():
    var list_sprite = get_characters_animated_sprite()
    for i in range(list_sprite.size()):
        var item_panel_instance = item_panel.instantiate()
        var existing_animated_sprite : AnimatedSprite2D = item_panel_instance.get_node("AnimatedSprite2D")
        var plane_animated_sprite = list_sprite[i]
        existing_animated_sprite.sprite_frames = plane_animated_sprite.sprite_frames
        grid_container.add_child(item_panel_instance)
    pass
