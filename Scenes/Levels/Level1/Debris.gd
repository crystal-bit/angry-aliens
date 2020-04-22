extends Node


export(PackedScene) var dust_scene
export(PackedScene) var explosion_scene
export(PackedScene) var debris_scene


func spawn_dust_particles(gpos, amount):
	var dust: Particles2D = dust_scene.instance()
	dust.amount = amount
	dust.emitting = true
	dust.global_position = gpos
	add_child(dust)


func spawn_debris(gpos, obstacle):
	var debris: Particles2D = debris_scene.instance()
	debris.texture = obstacle.get_debris_texture()
	debris.amount = 4 + randi() % 2
	debris.emitting = true
	debris.global_position = gpos
	add_child(debris)


func spawn_explosion(gpos):
	var explosion: AnimatedSprite = explosion_scene.instance()
	explosion.play()
	explosion.global_position = gpos
	add_child(explosion)


func _on_Obstacle_hit(obstacle, global_pos, was_destroyed):
	spawn_dust_particles(global_pos, 2 + randi() % 2 )
	if was_destroyed:
		spawn_debris(global_pos, obstacle)
		spawn_explosion(global_pos)


func _on_Projectile_body_entered(body, projectile: RigidBody2D):
	var speed = projectile.linear_velocity.length()
	if speed > 50:
		spawn_dust_particles(projectile.global_position, 1 + floor(speed / 100))


func _on_Slingshot_projectile_launched(projectile: RigidBody2D):
	spawn_dust_particles(projectile.global_position, 2 + randi() % 2)
