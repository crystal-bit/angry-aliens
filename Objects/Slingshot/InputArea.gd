extends Area2D

signal slingshot_released
signal slingshot_grabbed

export(NodePath) var slingshot_bone_path

onready var slingshot_bone: Bone2D = get_node(slingshot_bone_path)


func _input(event):
	if event is InputEventScreenTouch:
		if not event.is_pressed():
			emit_signal("slingshot_released")


func _on_InputArea_input_event(viewport, event: InputEvent, shape_idx):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			emit_signal("slingshot_grabbed")

	if event is InputEventPanGesture:
		pass

	if event is InputEventScreenDrag:
		pass

	if event is InputEventScreenTouch:
		pass
