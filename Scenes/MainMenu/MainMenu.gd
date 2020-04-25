extends ColorRect


onready var play_btn: TextureButton = $VBoxContainer/Play
onready var about_btn: TextureButton = $VBoxContainer/About
onready var exit_btn: TextureButton = $VBoxContainer/Exit


func _unhandled_input(event):
	# fix button no
	if event is InputEventScreenTouch:
		if Globals._is_btn_pressed(play_btn, event):
			play_btn.emit_signal("pressed")
		if Globals._is_btn_pressed(about_btn, event):
			about_btn.emit_signal("pressed")
		if Globals._is_btn_pressed(exit_btn, event):
			exit_btn.emit_signal("pressed")


func _on_About_pressed():
	Globals.main_scene.load_scene("res://Scenes/MainMenu/AboutScreen/AboutScreen.tscn")


func _on_Exit_pressed():
	get_tree().quit()


func _on_Play_pressed():
	Globals.main_scene.load_scene("res://Scenes/Levels/Level1/Level1.tscn")
