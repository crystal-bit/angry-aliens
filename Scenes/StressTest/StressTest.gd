extends Node2D

var enemy_scene = load("res://Objects/Enemy/Enemy.tscn")


func _ready():
	randomize()


func _on_SpawnTimer_timeout():
	var enemy_node = enemy_scene.instance()
	enemy_node.position = Vector2(rand_range(0, 1000), -100)
	add_child(enemy_node)

