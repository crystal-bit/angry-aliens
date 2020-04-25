extends Node

onready var overlay := $Overlay/OverlayRect
onready var overlay_anim := $Overlay/OverlayRect/AnimationPlayer


func _enter_tree():
	# register Main scene
	Globals.main_scene = self


func load_scene(new_scene: String):
	overlay_anim.play("fadein")
	yield(overlay_anim, "animation_finished")
	# swap scenes
	var cur_scene = $CurrentScene.get_child(0)
	$CurrentScene.remove_child(cur_scene)
	$CurrentScene.add_child(load(new_scene).instance())
	if cur_scene:
		cur_scene.queue_free()
	overlay_anim.play("fadeout")
#	yield(overlay_anim, "animation_finished")
#	print("Safe to start scene logic")
