extends Node2D

func _ready():
	return
	$Button.connect("pressed", self, "on_press", [$Button])
	$Button2.connect("pressed", self, "on_press", [$Button2])


func on_press(button):
	print(button.text)


func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if $Button.get_rect().has_point(event.position):
			print("A")
		if $Button2.get_rect().has_point(event.position):
			print("B")
		print("---")
