extends Node2D

var launch_force = Vector2(300, -200)
onready var projectile = get_parent().get_node("Projectile")


func _ready() -> void:
	$Projectile.mode = RigidBody2D.MODE_KINEMATIC
	$TrajectoryDrawer.draw_trajectory(launch_force, $Projectile.position)


func _on_Timer_timeout() -> void:
	$Projectile.mode = RigidBody2D.MODE_RIGID
	$Projectile.apply_impulse(Vector2(), launch_force)


func _draw() -> void:
	draw_line($Projectile.position, $Projectile.position + launch_force, Color.blue, 8)
