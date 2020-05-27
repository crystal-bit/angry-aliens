class_name Enemy
extends RigidBody2D

const DESTROY_THRESHOLD_BY_OBSTACLES = 400 # used if the collider is of type Obstacle
const DESTROY_THRESHOLD = 1600 # used for other type of colliders

signal destroyed(enemy_destroyed, collider, impact_momentum)


func _integrate_forces(state):
	for collision_idx in state.get_contact_count():
		var collider = state.get_contact_collider_object(collision_idx)
		if collider is RigidBody2D:
			var impact_momentum = collider.mass * collider.linear_velocity - mass * linear_velocity
			if impact_momentum.length() >= get_destruction_threshold(collider):
				emit_signal("destroyed", self, collider, impact_momentum)


func get_destruction_threshold(collider_type: RigidBody2D):
	match collider_type.get_class():
		"Obstacle":
			return DESTROY_THRESHOLD_BY_OBSTACLES
		"Projectile":
			return DESTROY_THRESHOLD
		_:
			return DESTROY_THRESHOLD


