extends Node

onready var overlay := $Overlay/OverlayRect
onready var overlay_anim := $Overlay/OverlayRect/AnimationPlayer
onready var current_scene_node := $CurrentScene


func _enter_tree():
	# register Main scene
	Globals.main_scene = self


func load_scene(new_scene: String, params = {}):
	print_debug(params)
	overlay_anim.play("fadein")
	yield(overlay_anim, "animation_finished")
	# swap scenes
	var cur_scene = current_scene_node.get_child(0)
	current_scene_node.remove_child(cur_scene)
	var new_instanced_scene = load(new_scene).instance()
	if new_instanced_scene.has_method("_post_init"):
		new_instanced_scene._post_init(params)
	current_scene_node.add_child(new_instanced_scene)
	if cur_scene:
		cur_scene.queue_free()
	overlay_anim.play("fadeout")
#	yield(overlay_anim, "animation_finished")
#	print("Safe to start scene logic")
