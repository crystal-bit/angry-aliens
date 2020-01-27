extends Control

signal resolution_selected

onready var checkboxes = [
	$VBoxContainer/HBoxContainer/iPhoneX,
	$VBoxContainer/HBoxContainer2/iPad
]

var resolutions = {
	"iPhoneX": [2436.0, 1125.0], # [w, h]
	"iPad": [1024.0, 768.0]
}


func _ready() -> void:
	for cbox in checkboxes:
		cbox.connect("toggled", self, "_on_checkbox_toggled", [cbox])


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_panel"):
		visible = !visible


func _on_checkbox_toggled(toggled, cbox):
	if cbox.pressed:
		var selected_res = resolutions[cbox.name]
		emit_signal("resolution_selected", selected_res)

	if cbox.pressed:
		# disable all the others check boxes
		for c in checkboxes:
			if c != cbox:
				c.pressed = false

