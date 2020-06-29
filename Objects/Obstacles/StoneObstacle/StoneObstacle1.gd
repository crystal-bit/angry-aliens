extends Obstacle
class_name StoneObstacle
# workaround for https://github.com/godotengine/godot/issues/21461
var StoneObstacleClassRef =  load("res://Objects/Obstacles/StoneObstacle/StoneObstacle1.gd")


# dependencies
onready var collision_shape := $CollisionShape2D
# vars
var start_damaged = true
# constants
const BREAK_TRESHOLD = 1800
const SMALL_HIT_TRESHOLD = 600


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


func _integrate_forces(state: Physics2DDirectBodyState):
	for c_id in state.get_contact_count():
		var collider = state.get_contact_collider_object(c_id)
		var collision_pos: Vector2 = state.get_contact_collider_position(c_id)
		var collider_velocity: Vector2 = state.get_contact_collider_velocity_at_position(c_id)

		# ignore TileMap collisions
		if collider is TileMap:
			return

		var break_point = BREAK_TRESHOLD
		# make it easier for projectiles to break the obstacle
		if collider is Projectile:
			break_point -= 1000
		
		# calculate momentums and forces
		var self_momentum = state.linear_velocity * mass
		var collider_momentum =  collider_velocity * collider.mass
		var impact_momentum = self_momentum - collider_momentum
		var impact_amount = impact_momentum.length()

		# react on collision based on the impact_amount
		if impact_amount < SMALL_HIT_TRESHOLD:
			return
		if impact_amount >= SMALL_HIT_TRESHOLD and impact_amount < break_point:
			emit_signal("hit", self, collision_pos, false)
		elif impact_amount >= break_point:
			if is_damaged():
				emit_signal("hit", self, collision_pos, true)
				if collider is StoneObstacleClassRef:
					collider.queue_free()
				queue_free()
			else:
				set_damaged(true)
				emit_signal("hit", self, global_position, false)
