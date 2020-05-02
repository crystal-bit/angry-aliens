extends Node2D


var far_speed = 25
var near_speed = 50

class cloud:
	var ref
	var speed: int
	var tween: Tween


var clouds_arr = []

onready var clouds = get_tree().get_nodes_in_group("clouds")


func _ready():
	randomize()
	for c in clouds:
		if c.get_parent().name == "Far":
			var cl = cloud.new()
			cl.ref = c
			cl.speed = far_speed + randi() % 20
			animate(cl)
			clouds_arr.append(cl)
		if c.get_parent().name == "Near":
			var cl = cloud.new()
			cl.ref = c
			cl.speed = near_speed + randi() % 20
			animate(cl)
			clouds_arr.append(cl)


func _process(delta):
	for el in clouds_arr:
		var c = el.ref # cloud
		var s = el.speed # speed
		c.position.x += s * delta
		if c.position.x > get_viewport_rect().size.x:
			c.position.x = -c.texture.get_size().x * c.scale.x
			c.position.y = rand_range(-10, 240)
			# reset tween
			el.tween.stop(el.ref)
			el.tween.start()


func horizontal_transition_time(speed):
	return get_viewport_rect().size.x / speed


func animate(cl):
	cl.tween = Tween.new()
	var duration = horizontal_transition_time(cl.speed)
	var random_scale = Vector2(
		cl.ref.scale.x * rand_range(0.8, 1.2),
		cl.ref.scale.y * rand_range(0.8, 1.2)
	)
	cl.tween.interpolate_property(cl.ref, "scale", cl.ref.scale, random_scale, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	cl.tween.interpolate_property(cl.ref, "position:y", cl.ref.position.y, cl.ref.position.y + rand_range(-80, 80), duration, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	add_child(cl.tween)
	cl.tween.start()

