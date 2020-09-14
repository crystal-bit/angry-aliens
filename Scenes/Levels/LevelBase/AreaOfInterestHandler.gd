extends Node


onready var camera_manager = get_node("../CameraFocus")


func _ready():
	yield(get_tree(), "idle_frame")
	for a in get_tree().get_nodes_in_group("area_of_interest"):
		var area: Area2D = a
		area.connect("body_exited", self, "_on_AreaOfInterest_body_exited")
		camera_manager.set_camera_limits(area)
		

func _on_AreaOfInterest_body_exited(body):
	if body is Projectile:
		# check only when the projectile is launched
		if body.state != Projectile.STATES.MOVING:
			return
		
		body.state = Projectile.STATES.STOPPED
		body.emit_signal("almost_stopped")
		body.queue_free()
