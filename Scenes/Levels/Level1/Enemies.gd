extends Node

onready var scores: Node = get_parent().get_node("Scores")

signal enemy_destroyed


func _ready():
	for enemy in get_children():
		enemy.connect("destroyed", self, "_on_enemy_destroyed")


func _on_enemy_destroyed(enemy: RigidBody2D, collider: PhysicsBody2D, impact_momentum: Vector2):
	emit_signal("enemy_destroyed", enemy, impact_momentum)
	enemy.queue_free()
