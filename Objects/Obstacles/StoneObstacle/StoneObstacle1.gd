extends Obstacle
class_name StoneObstacle

export var breaking_point = 200
export var start_damaged = false

signal destroyed
signal hit


func _ready():
	set_damaged(start_damaged)


func set_damaged(damaged):
	if damaged:
		$Sprite.hide()
		$SpriteDamaged.show()
	else:
		$Sprite.show()
		$SpriteDamaged.hide()


func is_damaged():
	return $SpriteDamaged.visible


func _on_StoneObstacle1_body_entered(body):
	if not (body is RigidBody2D):
		return
	if body.linear_velocity.length() > breaking_point or linear_velocity.length() > breaking_point:
		if is_damaged():
			emit_signal("hit", self, body.global_position, true)
			queue_free()
		else:
			emit_signal("hit", self, body.global_position, false)
			set_damaged(true)
