extends Node

""" Handles the scores appearing when the projectile
hits obstacles or enemies. """


signal points_gained

onready var scores_pool =  $ScoresPool

const ENEMY_DESTROYED_POINTS = 500

var angle_randomness = 30


func _on_Enemies_enemy_destroyed(enemy):
	var score_node: Node2D = scores_pool.get_instance()
	add_child(score_node)
	score_node.rotation_degrees = (randi() % angle_randomness) - (angle_randomness % 2)
	score_node.global_position = enemy.global_position
	score_node.score_value = ENEMY_DESTROYED_POINTS + randi() % 100
	score_node.show()
	emit_signal("points_gained", score_node.score_value)
	score_node.connect("score_hidden", self, "_on_score_hidden_remove_score")


func _on_score_hidden_remove_score(score):
	score.can_be_pooled = true
