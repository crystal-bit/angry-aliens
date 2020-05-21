extends Node


var main_scene: Node


func goto_scene(new_scene: String):
	# TODO: check if already transitioning
	if main_scene == null:
		return get_tree().change_scene(new_scene)
	main_scene.load_scene(new_scene)

