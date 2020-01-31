""" Detect touch inputs and dispatch signals to the Slingshot node. 
"""
extends Area2D

signal slingshot_released
signal slingshot_grabbed
signal slingshot_moved

export(NodePath) var slingshot_bone_path

onready var slingshot_bone: Bone2D = get_node(slingshot_bone_path)

var grabbed = false


func _input(event):
	if event is InputEventScreenTouch:
		if not event.is_pressed():
			emit_signal("slingshot_released")
			grabbed = false
	
	if event is InputEventScreenDrag:
		if grabbed:
			emit_signal("slingshot_moved", event.position)


func _on_InputArea_input_event(viewport, event: InputEvent, shape_idx):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			emit_signal("slingshot_grabbed")
			grabbed = true
