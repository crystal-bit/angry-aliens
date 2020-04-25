extends Node


var main_scene: Node


func goto_scene(new_scene: String):
	# TODO: check if already transitioning
	main_scene.load_scene(new_scene)


func _is_btn_pressed(btn: TextureButton, event: InputEventScreenTouch):
	if not event is InputEventScreenTouch:
		print("ERROR: Event ", event, " is not InputEventScreenTouch")
		return
	if Rect2(btn.get_global_rect().position, btn.rect_size).has_point(event.position):
		return true
