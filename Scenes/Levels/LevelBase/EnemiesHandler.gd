extends Node


signal enemy_destroyed


func _ready():
	for enemy in get_tree().get_nodes_in_group("enemy"):
		enemy.connect("destroyed", self, "_on_enemy_destroyed")


func _on_enemy_destroyed(enemy: RigidBody2D, collider: PhysicsBody2D, impact_momentum: Vector2):
	emit_signal("enemy_destroyed", enemy, impact_momentum)
	enemy.queue_free()
