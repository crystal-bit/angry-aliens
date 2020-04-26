extends ColorRect

onready var back_button = $NinePatchRect/MarginContainer/VBoxContainer/Back
onready var github_button = $NinePatchRect/MarginContainer/VBoxContainer/Github


func _unhandled_input(event):
	if event is InputEventScreenTouch:
		if Globals._is_btn_pressed(back_button, event):
			back_button.emit_signal("pressed")
		if Globals._is_btn_pressed(github_button, event):
			github_button.emit_signal("pressed")


func _on_Github_pressed():
	OS.shell_open("https://github.com/crystal-bit/angry-aliens")


func _on_Back_pressed():
	Globals.goto_scene("res://Scenes/MainMenu/MainMenu.tscn")
