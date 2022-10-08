extends Node


var main_scene: Node
var music_player: AudioStreamPlayer = AudioStreamPlayer.new()

onready var current_level_index = 1


func _ready():
	var bgm_path = "res://Assets/music/monkeys-spinning-monkeys.ogg"
	if File.new().file_exists(bgm_path):
		var music = load(bgm_path)
		music_player.stream = music
		
		var music_bus_id = AudioServer.get_bus_count()
		AudioServer.add_bus()
		AudioServer.set_bus_name(music_bus_id,"music")
		# connects music to master bus
		AudioServer.set_bus_send(music_bus_id,"Master")

		add_child(music_player)
		music_player.bus = "music"


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
