extends Area2D


func _on_AreaOfInterest_body_exited(body):
	if body is Projectile:
		# check only when the projectile is launched
		if body.state != Projectile.STATES.MOVING:
			return

		body.state = Projectile.STATES.STOPPED
		body.emit_signal("almost_stopped")
		body.queue_free()
