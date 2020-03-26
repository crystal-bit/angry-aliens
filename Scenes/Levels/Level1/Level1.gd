extends Node2D


onready var projectile = $Projectile # TODO: this needs to be updated
onready var vfx_manager = $ParticlesManager


func _ready():
	projectile.connect("body_entered", vfx_manager, "_on_Projectile_body_entered", [projectile])


func _on_ReloadSceneBtn_pressed():
	get_tree().reload_current_scene()
