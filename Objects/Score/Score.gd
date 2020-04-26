extends PoolableNode2D
#tool

signal score_hidden

export (String, "left", "center") var grow_direction = "center"
export(int) var score_value = 0 setget set_score
export(int) var distance = 0 setget set_distance

onready var sprites = $Sprites # sprites container
onready var increase_tween = $Tween
var textures_cache = []

var inited = false


func _ready():
	init_texture_cache()
	inited = true
	_update_sprites()


func init_texture_cache():
	for i in range(10):
		textures_cache.append(_get_texture_for_num(i))


func set_score(value: int):
	if !value is int:
		print("Error in set_score: value has to be integer")
		return
	score_value = value
	if inited:
		_update_sprites()


func set_distance(val):
	distance = val
	if inited:
		_update_sprites()


func appear_animation():
	var delay = 0
	# create tween
	var tween = Tween.new()
	add_child(tween)
	# for each number sprite
	for spr in sprites.get_children():
#		spr.modulate = Color(1,1,1,1)
		tween.interpolate_property(
			spr,
			"scale",
			Vector2(),
			Vector2(1, 1),
			1,
			Tween.TRANS_ELASTIC,
			Tween.EASE_OUT,
			delay
		)
		delay += 0.05
	tween.start()


func increase(points):
	var duration = 1
	if increase_tween.is_active():
		increase_tween.stop_all()
		increase_tween.seek(duration) # update the score to the final value
	increase_tween.interpolate_property(self,
		"score_value",
		score_value,
		score_value + points,
		duration, Tween.TRANS_LINEAR, Tween.EASE_IN
	)
	increase_tween.start()


func show():
	.show()
	appear_animation()
	var tween = Tween.new()
	add_child(tween)
	tween.interpolate_property(self,
		"modulate:a", 1, 0, 0.5, Tween.TRANS_EXPO, Tween.EASE_IN, 0.7)
	tween.start()
	yield(tween, "tween_completed")
	can_be_pooled = true
	emit_signal("score_hidden", self)


func _update_sprites(animate=false):
	# create missing sprites or pool unused sprites
	var missing_digits_sprites = len(str(score_value)) - sprites.get_child_count()
	if missing_digits_sprites > 0:
		for i in range(missing_digits_sprites):
			var spr = _create_number()
			sprites.add_child(spr)
	elif missing_digits_sprites < 0:
		for i in range(-missing_digits_sprites):
			$ScorePool.pool(sprites.get_child(0))
	# reset sprites
	for c in sprites.get_children():
		c.position = Vector2()
	# set layout
	var first_spr: Sprite = null
	var last_spr: Sprite = null
	var idx = 0
	for digit in str(score_value):
		var num_spr: Sprite = sprites.get_child(idx)
		num_spr.texture = textures_cache[int(digit)]
		if first_spr == null:
			first_spr = num_spr
		# if there is a previous
		if last_spr:
				num_spr.position.x = last_spr.position.x + last_spr.texture.get_size().x + distance
		num_spr.name = "Sprite" + digit
		last_spr = num_spr
		idx+=1
	match grow_direction:
		"center":
			_center_sprites(first_spr, last_spr)
		"left":
			_grow_left(first_spr, last_spr)
		_:
			print("ERROR: ", grow_direction, " grow_direction not implemented")
	if animate:
		appear_animation()


func _center_sprites(first_spr: Sprite, last_spr: Sprite):
	var width = last_spr.position.x + last_spr.texture.get_size().x - first_spr.position.x - first_spr.texture.get_size().x / 2
	# translate all the sprites to center them
	for spr in sprites.get_children():
		spr.position.x -= width / 2


func _grow_left(first_spr: Sprite, last_spr: Sprite):
	if sprites.get_child_count() == 0:
		return
	var width = last_spr.position.x + last_spr.texture.get_size().x / 2 - first_spr.position.x - first_spr.texture.get_size().x / 2
	for spr in sprites.get_children():
		spr.position.x -= width


func _create_number() -> Sprite:
	return $ScorePool.get_instance()


func _get_texture_for_num(num):
	assert(num >= 0 and num <= 9)
	var texture_path = "res://Assets/graphics/kenney2/numbers/hud{n}.png".format({"n": num})
	return load(texture_path)
