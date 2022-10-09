extends ColorRect

func _ready():
	randomize()


func _on_Level1_pressed():
	_go_to_level(1)


func _on_Level2_pressed():
	_go_to_level(2)


func _on_Level3_pressed():
	_go_to_level(3)


func _on_Back_pressed():
	Globals.goto_scene("res://Scenes/MainMenu/MainMenu.tscn")


func _go_to_level(level : int):
	Globals.music_player.stop()
	Globals.goto_scene("res://Scenes/Levels/LevelBase/LevelBase.tscn", { 'level': level })
