extends Node

export(PackedScene) var dust_scene
export(PackedScene) var explosion_scene
export(PackedScene) var debris_scene

onready var _debris := $Debris
onready var _dust := $Dust
onready var _explosions := $Explosions

onready var pool = {
	"debris": $DebrisPool,
	"dust": $DustPool,
	"explosions": $ExplosionsPool
}

var pool_size = 5


func _ready():
	# Populate pool
	for i in range(pool_size):
		pool.debris.add_child(create_debris())
		pool.dust.add_child(create_dust())
		pool.explosions.add_child(create_explosion())
	# schedule pool refresh
	var timer := Timer.new()
	add_child(timer)
	timer.start()
	timer.connect("timeout", self, "check_unused_objs")


func spawn_dust_particles(gpos, amount):
	var dust: Particles2D = pool.dust.get_child(0)
	if dust == null:
		print("Pool: EMPTY. Creating new dust object.")
		dust = create_dust()
	else:
		pool.dust.remove_child(dust)
	dust.z_index = 0
	dust.amount = amount
	dust.emitting = true
	dust.global_position = gpos
	if dust.get_parent() == null:
		_dust.add_child(dust)


func spawn_debris(gpos, obstacle, auto_emit = true):
	var debris: Particles2D = pool.debris.get_child(0)
	if debris == null:
		print("Pool: EMPTY. Creating new debris object.")
		debris = create_debris()
	else:
		pool.debris.remove_child(debris)
	debris.z_index = 0
	debris.texture = obstacle.get_debris_texture()
	debris.emitting = true
	debris.global_position = gpos
	_debris.add_child(debris)


func spawn_explosion(gpos):
	var explosion: AnimatedSprite = pool.explosions.get_child(0)
	if explosion == null:
		print("Pool: EMPTY. Creating new explosion object.")
		explosion = create_explosion()
	else:
		pool.explosions.remove_child(explosion)
	explosion.z_index = 0
	explosion.play()
	explosion.global_position = gpos
	_explosions.add_child(explosion)


func create_dust():
	var dust = dust_scene.instance()
	dust.emitting = true
	dust.z_index = -999
	return dust


func create_debris():
	var debris: Particles2D = debris_scene.instance()
	debris.amount = 4 + randi() % 2
	debris.emitting = true
	debris.z_index = -999
	return debris


func create_explosion():
	var explosion = explosion_scene.instance()
	explosion.z_index = -999
	return explosion


func check_unused_objs():
	# debris
	var counter = 0
	for d in _debris.get_children():
		if d.emitting == false:
			counter += 1
			_debris.remove_child(d)
			pool.debris.add_child(d)
#	print("Pool: pooled ", counter, " Debris objects.")
	# dust
	counter = 0
	for d in _dust.get_children():
		if d.emitting == false:
			counter += 1
			_dust.remove_child(d)
			pool.dust.add_child(d)
#	print("Pool: pooled ", counter, " Dust objects.")
	# explosions
	counter = 0
	for e in _explosions.get_children():
		if e.playing == false and !e.tween.is_active():
			counter += 1
			_explosions.remove_child(e)
			pool.explosions.add_child(e)
#	print("Pool: pooled ", counter, " Explosions objects.")
#	print("---")


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
