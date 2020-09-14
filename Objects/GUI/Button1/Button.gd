extends TextureButton
tool
export(String) var text setget _set_btn_text


func _ready():
	connect("pressed", self, "_on_pressed")


func _unhandled_input(event):
	if disabled:
		return
	# fix button on smartphone
	if event is InputEventScreenTouch:
		if _is_btn_pressed(self, event):
			emit_signal("pressed")


func _is_btn_pressed(btn: BaseButton, event: InputEventScreenTouch):
	if not event is InputEventScreenTouch:
		print("ERROR: Event ", event, " is not InputEventScreenTouch")
		return
	if Rect2(btn.get_global_rect().position, btn.rect_size).has_point(event.position):
		return true


func _on_pressed():
	$AudioStreamPlayer.play()


func _set_btn_text(value):
	# fix issue #20 in develop branch
	if $Label != null:
		$Label.text = value
	text = value

