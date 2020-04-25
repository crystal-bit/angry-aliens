extends Node2D


var far_speed = 20
var near_speed = 30

var clouds_speed = []

onready var clouds = get_tree().get_nodes_in_group("clouds")


func _ready():
	randomize()
	for c in clouds:
		if c.get_parent().name == "Far":
			clouds_speed.append([c, far_speed + randi() % 20])
		if c.get_parent().name == "Near":
			clouds_speed.append([c, near_speed + randi() % 20])


func _process(delta):
	for el in clouds_speed:
		var c = el[0] # cloud
		var s = el[1] # speed
		c.position.x += s * delta
		if c.position.x > get_viewport_rect().size.x:
			c.position.x = -c.texture.get_size().x * c.scale.x
			c.position.y = rand_range(-10, 240)


