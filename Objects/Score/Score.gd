extends Node2D
tool


export(int) var score_value setget set_score
export(int) var distance = 0 setget set_distance


func set_score(value: int):
	if !value is int:
		print("Error in set_score: value has to be integer")
		return
	score_value = value
	_update_sprites()


func set_distance(val):
	distance = val
	_update_sprites()


func _update_sprites(animate=true):
	# remove old score sprites
	for c in get_children():
		c.queue_free()
		remove_child(c)
	# add new score sprites
	for digit in str(score_value):
		var num_spr: Sprite = _create_number(int(digit))
		if get_child_count() > 0:
			var last_num: Sprite = get_child(get_child_count() - 1)
			num_spr.position.x = last_num.position.x + last_num.texture.get_size().x + distance
		num_spr.name = "Sprite" + digit
		add_child(num_spr)
	if animate:
		appear_animation()


func appear_animation():
	var delay = 0
	for spr in get_children():
		var tween = Tween.new()
		add_child(tween)
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



func _create_number(num) -> Sprite:
	assert(num >= 0 and num <= 10)
	var spr = Sprite.new()
	var texture_path = "res://Assets/graphics/kenney2/numbers/hud{n}.png".format({"n": num})
	var texture = load(texture_path)
	spr.texture = texture
	spr.position = Vector2(100, 100)
	return spr



