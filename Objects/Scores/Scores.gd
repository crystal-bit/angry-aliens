extends Node

""" Handles the scores appearing when the projectile
hits obstacles or enemies. """


func _ready():
	pass


func _on_Enemies_enemy_destroyed(enemy):
	print(enemy)
