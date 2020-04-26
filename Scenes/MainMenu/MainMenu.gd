extends ColorRect


func _on_About_pressed():
	Globals.goto_scene("res://Scenes/MainMenu/AboutScreen/AboutScreen.tscn")


func _on_Exit_pressed():
	get_tree().quit()


func _on_Play_pressed():
	Globals.goto_scene("res://Scenes/Levels/Level1/Level1.tscn")
