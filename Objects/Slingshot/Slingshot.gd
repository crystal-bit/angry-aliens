extends Node2D

var current_projectile = null

onready var projectiles = get_tree().get_nodes_in_group("projectiles")

func _ready():
	pass


func load_projectile():
#	projectile =
	if len(projectiles) > 0:
		current_projectile = projectiles.pop_back()
		current_projectile.global_position = $RestPosition.global_position



func launch_projectile(proj: RigidBody2D, launch_impulse):
	proj.mode = RigidBody2D.MODE_RIGID
	proj.apply_central_impulse(launch_impulse)
	current_projectile = null


func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			if current_projectile:
				launch_projectile(current_projectile, Vector2(200, -100))
			else:
				load_projectile()

