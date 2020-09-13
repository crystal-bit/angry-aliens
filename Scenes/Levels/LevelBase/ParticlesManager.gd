extends Node

export(PackedScene) var dust_scene
export(PackedScene) var explosion_scene
export(PackedScene) var debris_scene

onready var _debris := $Debris
onready var _dust := $Dust
onready var _explosions := $Explosions

onready var audio = get_parent().get_node("Audio")


func _ready():
	var timer := Timer.new()
	add_child(timer)
	timer.start()
	timer.connect("timeout", self, "check_unused_objs")
	
	# connect scene obstacles to the particles and sfx
	for obstacle in get_tree().get_nodes_in_group("obstacle"):
		if not obstacle is Obstacle:
			print_debug(obstacle, " is not of type Obstacle") 
		obstacle.connect("hit", audio, "_on_Obstacle_hit")
		if obstacle is StoneObstacle:
			obstacle.connect("hit", self, "_on_Obstacle_hit")


func spawn_dust_particles(gpos, amount):
	var dust: CPUParticles2D = create_dust()
	dust.amount = amount
	dust.emitting = true
	dust.global_position = gpos
	_dust.add_child(dust)


func spawn_debris(gpos, obstacle, auto_emit = true):
	var debris = create_debris()
	debris.texture = obstacle.get_debris_texture()
	debris.emitting = true
	debris.global_position = gpos
	_debris.add_child(debris)


func spawn_explosion(gpos):
	var explosion: AnimatedSprite = create_explosion()
	explosion.play()
	explosion.global_position = gpos
	_explosions.add_child(explosion)


func create_dust() -> CPUParticles2D:
	var dust = dust_scene.instance()
	return dust


func create_debris() -> CPUParticles2D:
	var debris = debris_scene.instance()
	debris.amount = 4 + randi() % 2
	return debris


func create_explosion():
	var explosion = explosion_scene.instance()
	return explosion


func check_unused_objs():
	# debris
	for d in _debris.get_children():
		if d.emitting == false:
			d.queue_free()
	# dust
	for d in _dust.get_children():
		if d.emitting == false:
			d.queue_free()
	# explosions
	for e in _explosions.get_children():
		if e.playing == false and !e.tween.is_active():
			e.queue_free()


func _on_Obstacle_hit(obstacle, global_pos, was_destroyed):
	spawn_dust_particles(global_pos, 1 + randi() % 2 )
	if was_destroyed:
		spawn_debris(global_pos, obstacle)
		spawn_explosion(global_pos)


func _on_Projectile_body_entered(body, projectile: RigidBody2D):
	var speed = projectile.linear_velocity.length()
	if speed > 50:
		spawn_dust_particles(projectile.global_position, 1 + floor(speed / 100))


func _on_Slingshot_projectile_launched(projectile: RigidBody2D):
	spawn_dust_particles(projectile.global_position, 2 + randi() % 2)
