extends ColorRect

func _ready():
	pass


func _on_Github_pressed():
	OS.shell_open("https://github.com/crystal-bit/angry-aliens")


func _on_Back_pressed():
	Globals.goto_scene("res://Scenes/MainMenu/MainMenu.tscn")
