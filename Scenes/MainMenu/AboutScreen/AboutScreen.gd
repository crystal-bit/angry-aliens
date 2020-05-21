extends ColorRect

onready var back_button = $NinePatchRect/MarginContainer/VBoxContainer/Back
onready var github_button = $NinePatchRect/MarginContainer/VBoxContainer/Github


func _on_Github_pressed():
	OS.shell_open("https://github.com/crystal-bit/angry-aliens")


func _on_Back_pressed():
	Globals.goto_scene("res://Scenes/MainMenu/MainMenu.tscn")
