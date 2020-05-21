extends Obstacle
class_name StoneObstacle

var start_damaged = true

const BREAK_TRESHOLD = 150
const SMALL_HIT_TRESHOLD = 30


signal destroyed


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

	var impact_amount = (body.linear_velocity - self.linear_velocity).length()

	if impact_amount < SMALL_HIT_TRESHOLD:
		return
	if impact_amount >= SMALL_HIT_TRESHOLD and impact_amount < BREAK_TRESHOLD:
		emit_signal("hit", self, body.global_position, false)
	elif impact_amount >= BREAK_TRESHOLD:
		print("serious hit")
		if is_damaged():
			queue_free()
			emit_signal("hit", self, body.global_position, true)
		else:
			set_damaged(true)
			emit_signal("hit", self, body.global_position, false)
