extends TextureButton
tool
export(String) var text setget _set_btn_text


func _unhandled_input(event):
	# fix button on smartphone
	if event is InputEventScreenTouch:
		if Globals._is_btn_pressed(self, event):
			emit_signal("pressed")


func _set_btn_text(value):
	$Label.text = value
	text = value
