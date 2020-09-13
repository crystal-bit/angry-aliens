extends Node


var main_scene: Node

onready var current_level_index = 1


func goto_scene(new_scene: String, params = {}):
	# if there is no main_scene, fallback to default Godot change_scene
	if main_scene == null:
		return get_tree().change_scene(new_scene)
	main_scene.load_scene(new_scene, params)


func get_level_path(level: int) -> String:
	var levels_base_path = "res://Scenes/Levels/LevelNodes/"
	var levels_path = {
		1: levels_base_path + "Level1.tscn",
		2: levels_base_path + "Level2.tscn",
		3: levels_base_path + "Level3.tscn",
	}
	return levels_path.get(level)
