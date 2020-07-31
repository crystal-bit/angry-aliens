extends Node

var body: RigidBody2D


func _ready():
	body = get_parent()
	

func handle_collision(state):
	for collision_index in state.get_contact_count():
		var collider = state.get_contact_collider_object(collision_index)
		if collider is RigidBody2D:
			var collider_velocity = state.get_contact_collider_velocity_at_position(collision_index)
			_on_rigid_body_collision(collider, collider_velocity, state.linear_velocity)


func _on_rigid_body_collision(collider, collider_velocity, body_velocity):
	var collider_momentum = collider_velocity * collider.mass
	var enemy_momentum = body_velocity * body.mass
	var collision_intensity = (collider_momentum - enemy_momentum).length()
	
	body.on_collision(collider, collision_intensity)
