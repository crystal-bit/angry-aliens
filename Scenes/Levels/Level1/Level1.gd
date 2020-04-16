extends Node2D


onready var vfx_manager = $ParticlesManager


func _ready():
	for projectile in get_tree().get_nodes_in_group("projectile"):
		projectile.connect("body_entered", vfx_manager, "_on_Projectile_body_entered", [projectile])


func _on_TouchScreenButton_released():
	get_tree().reload_current_scene()
