extends Node


export(int) var force_to_destroy_enemy = 200


func _ready():
	for enemy in get_children():
		enemy.connect("body_entered", self, "_on_enemy_body_entered", [enemy])


func _on_enemy_body_entered(body, enemy: RigidBody2D):
	if body is RigidBody2D:
		if body.linear_velocity.length() + enemy.linear_velocity.length() > force_to_destroy_enemy:
			enemy.queue_free()
