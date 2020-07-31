extends RigidBody2D

const DESTRUCTION_THRESHOLD = 100


func _integrate_forces(state):
	$CollisionHandler.handle_collision(state)


func on_collision(collider, collision_intensity):
	if collision_intensity > DESTRUCTION_THRESHOLD:
		queue_free()
