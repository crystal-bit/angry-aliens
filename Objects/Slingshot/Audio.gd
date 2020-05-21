extends Node

onready var aiming = $Aiming
onready var released = $Released
onready var swish = $Swish
onready var slingshot = get_parent()

var last_projectile_pos = Vector2()


func _on_Slingshot_projectile_launched(projectile):
	released.play()
	swish.play()


func _process(delta):
	if aiming.playing:
		return

	if slingshot.state == slingshot.States.AIMING:
		if last_projectile_pos:
			if last_projectile_pos.distance_to(slingshot.projectile.position) > 50:
				aiming.play()
				last_projectile_pos = slingshot.projectile.position
		else:
			last_projectile_pos = slingshot.projectile.position
	else:
		aiming.stop()
		last_projectile_pos = null

