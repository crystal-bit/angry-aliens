class_name Projectile
extends RigidBody2D

signal almost_stopped

enum STATES {
	IDLE, # waiting to be loaded on the slingshot
	MOVING, # moving after being launched from the slingshot
	LAUNCHED # stopped after being launched
}

onready var trail: CPUParticles2D = $Trail

var state = STATES.IDLE


func get_width() -> float:
	return $Sprite.texture.get_size().x * $Sprite.global_scale.x


func get_height() ->float:
	return $Sprite.texture.get_size().y * $Sprite.global_scale.y


func apply_impulse(offset: Vector2, impulse: Vector2):
	.apply_impulse(offset, impulse)
	state = STATES.MOVING


func _physics_process(delta):
	trail.emitting = false
	match state:
		STATES.IDLE:
			pass
		STATES.MOVING:
			trail.emitting = true
			trail.initial_velocity = linear_velocity.length() / 10
			trail.direction = -linear_velocity.normalized()
			trail.rotation = -rotation
			_moving_process()
		STATES.LAUNCHED:
			pass


func _moving_process():
	if linear_velocity.length() < 10 and len(get_colliding_bodies()) > 0:
		emit_signal("almost_stopped")
		state = STATES.LAUNCHED
