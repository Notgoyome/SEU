extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func is_outside_camera_view(global_position: Vector2) -> bool:
	var camera = get_viewport().get_camera_2d()
	var camera_rect = null
	var object_position = global_position
	var left_padding = -64
	var right_padding = -64
	var top_padding = 0
	var bottom_padding = 0

	if camera != null:
		camera_rect = Rect2(camera.global_position - camera.zoom * camera.get_screen_size() / 2, camera.zoom * camera.get_screen_size())
	else:
		var visible_rect = get_viewport().get_visible_rect()
		camera_rect = Rect2(Vector2(-left_padding, -top_padding), visible_rect.size + Vector2(left_padding + right_padding, top_padding + bottom_padding))
	return not camera_rect.has_point(object_position)