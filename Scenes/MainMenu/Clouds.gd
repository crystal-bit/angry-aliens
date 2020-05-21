extends Node2D

onready var aliens_tween := $AliensTween
onready var clouds = get_tree().get_nodes_in_group("clouds")

var far_speed = 25
var near_speed = 50

var clouds_arr = []

class Cloud:
	var obj
	var speed: int
	var sprite: Sprite
	var tween: Tween


func _ready():
	randomize()
	for c in clouds:
		if c.get_parent().name == "Far":
			var cl = Cloud.new()
			cl.obj = c
			cl.sprite = c.find_node("CloudSprite")
			cl.speed = far_speed + randi() % 20
			animate(cl)
			clouds_arr.append(cl)
		if c.get_parent().name == "Near":
			var cl = Cloud.new()
			cl.obj = c
			cl.sprite = c.find_node("CloudSprite")
			cl.speed = near_speed + randi() % 20
			animate(cl)
			clouds_arr.append(cl)


func _show_alien():
	var rnd_cloud = clouds_arr[randi() % clouds_arr.size()]
	rnd_cloud.obj.show_alien()


func _process(delta):
	for el in clouds_arr:
		var c = el.obj as Node2D
		var s = el.speed
		c.position.x += s * delta
		var sprite_width = el.sprite.texture.get_size().x * c.scale.x
		if c.position.x - sprite_width / 2 > get_viewport_rect().size.x:
			c.position.x = -sprite_width / 2
			c.position.y = rand_range(-10, 240)
			# reset tween
			el.tween.stop(el.obj)
			el.tween.start()


func horizontal_transition_time(speed):
	return get_viewport_rect().size.x / speed


func animate(cl):
	cl.tween = Tween.new()
	var duration = horizontal_transition_time(cl.speed)
	var random_scale = Vector2(
		cl.obj.scale.x * rand_range(0.8, 1.2),
		cl.obj.scale.y * rand_range(0.8, 1.2)
	)
	cl.tween.interpolate_property(cl.obj, "scale", cl.obj.scale, random_scale, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	cl.tween.interpolate_property(cl.obj, "position:y", cl.obj.position.y, cl.obj.position.y + rand_range(-80, 80), duration, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	add_child(cl.tween)
	cl.tween.start()

