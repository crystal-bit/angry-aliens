extends Node


onready var path = $Path2D
onready var path_follow = $Path2D/PathFollow2D
onready var tween = $Tween
onready var slingshot = get_node("../Slingshot")


func _ready():
	load_projectile()


func load_projectile():
	var proj = get_child(0)
	if proj == null or !(proj is Projectile):
		return
	# reparent
	$Proxy.position = proj.position
	remove_child(proj)
	$Proxy.add_child(proj)
	proj.position = Vector2()
	# start animation
	$AnimationPlayer.play("load_projectile")
	# wait it to finish
	yield($AnimationPlayer, "animation_finished")
	# reparent and load projectile
	$Proxy.remove_child(proj)
	get_parent().add_child(proj)
	proj.position = $Proxy.position
	slingshot.load_projectile(proj)


func _on_Slingshot_projectile_launched(projectile):
	yield(get_tree().create_timer(1), "timeout")
	load_projectile()
