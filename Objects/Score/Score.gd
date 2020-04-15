extends Node2D
tool


export(int) var score_value setget set_score
export(int) var distance = 0 setget set_distance


signal score_hidden


func set_score(value: int):
	if !value is int:
		print("Error in set_score: value has to be integer")
		return
	score_value = value
	_update_sprites()


func set_distance(val):
	distance = val
	_update_sprites()


func appear_animation():
	var delay = 0
	# create tween
	var tween = Tween.new()
	add_child(tween)
	# for each number sprite
	for spr in get_children():
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


func show():
	.show()
	appear_animation()
	var tween = Tween.new()
	add_child(tween)
	tween.interpolate_property(self,
		"modulate:a", 1, 0, 0.5, Tween.TRANS_EXPO, Tween.EASE_IN, 0.7)
	tween.start()
	yield(tween, "tween_completed")
	emit_signal("score_hidden", self)


func _update_sprites(animate=false):
	# remove old score sprites
	for c in get_children():
		remove_child(c)
		c.queue_free()
	# add new score sprites
	var first_spr = null
	var last_spr = null
	for digit in str(score_value):
		var num_spr: Sprite = _create_number(int(digit))
		if first_spr == null:
			first_spr = num_spr
		# if at least one number was created
		if get_child_count() > 0:
			var previous: Sprite = get_child(get_child_count() - 1)
			num_spr.position.x = previous.position.x + previous.texture.get_size().x + distance
		num_spr.name = "Sprite" + digit
		add_child(num_spr)
		last_spr = num_spr
	_center_sprites(first_spr, last_spr)
	if animate:
		appear_animation()


func _center_sprites(first_spr: Sprite, last_spr: Sprite):
	var width = last_spr.position.x + last_spr.texture.get_size().x - first_spr.position.x
	# translate all the sprites to center them
	for spr in get_children():
		spr.position.x -= width / 2


func _create_number(num) -> Sprite:
	assert(num >= 0 and num <= 10)
	var spr = Sprite.new()
	var texture_path = "res://Assets/graphics/kenney2/numbers/hud{n}.png".format({"n": num})
	var texture = load(texture_path)
	spr.texture = texture
	return spr
