extends Control

onready var touch_button: TouchScreenButton = get_child(0)


func _ready():
	touch_button.position.x -= touch_button.normal.get_size().x / 2
