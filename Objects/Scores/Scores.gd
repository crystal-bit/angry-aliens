extends Node

""" Handles the scores appearing when the projectile
hits obstacles or enemies. """

export(PackedScene) var score_scene

signal points_gained

const ENEMY_DESTROYED_POINTS = 500

var angle_randomness = 30


func _ready():
	pass


func _on_Enemies_enemy_destroyed(enemy):
	var score_node: Node2D = _create_score()
	add_child(score_node)
	score_node.rotation_degrees = (randi() % angle_randomness) - (angle_randomness % 2)
	score_node.global_position = enemy.global_position
	score_node.score_value = ENEMY_DESTROYED_POINTS + randi() % 100
	score_node.show()
	emit_signal("points_gained", score_node.score_value)
	score_node.connect("score_hidden", self, "_on_score_hidden_remove_score")


func _create_score():
	return score_scene.instance()


func _on_score_hidden_remove_score(score):
	score.queue_free()
