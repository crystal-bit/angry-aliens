extends RigidBody2D

const DESTRUCTION_THRESHOLD = 250


#func _on_Enemy_body_entered(body):
#	if body is RigidBody2D:
#		_on_rigid_body_collision(body)


func _on_rigid_body_collision(collider):
	var collider_momentum = collider.linear_velocity * collider.mass
	var enemy_momentum = linear_velocity * mass
	var collision_intensity = (collider_momentum - enemy_momentum).length()
	if collision_intensity > DESTRUCTION_THRESHOLD:
		queue_free()


func _on_rigid_body_collision_v2(collider, collider_velocity, enemy_velocity):
	var collider_momentum = collider_velocity * collider.mass
	var enemy_momentum = enemy_velocity * mass
	var collision_intensity = (collider_momentum - enemy_momentum).length()
	if collision_intensity > DESTRUCTION_THRESHOLD:
		queue_free()
		

func _integrate_forces(state):
	for collision_index in state.get_contact_count():
		var collider = state.get_contact_collider_object(collision_index)
		if collider is RigidBody2D:
			var collider_velocity = state.get_contact_collider_velocity_at_position(collision_index)
			_on_rigid_body_collision_v2(collider, collider_velocity, state.linear_velocity)
