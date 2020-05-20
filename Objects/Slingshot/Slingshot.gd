extends Node2D

const MAX_DISTANCE = 150

export(int) var elastic_factor = 4

var current_projectile = null
var launch_force := Vector2()

onready var projectiles = get_tree().get_nodes_in_group("projectiles")
onready var rest = $RestPosition

func _ready():
	load_projectile()


func load_projectile():
	if len(projectiles) > 0:
		current_projectile = projectiles.pop_back()
		current_projectile.global_position = rest.global_position


func launch_projectile(proj: RigidBody2D, launch_impulse):
	proj.mode = RigidBody2D.MODE_RIGID
	proj.apply_central_impulse(launch_impulse * elastic_factor)
	current_projectile = null


func _input(event):
	pass


func _unhandled_input(event):
	if current_projectile == null:
		return
	if event is InputEventScreenTouch:
		if event.pressed:
			print("touched")
			_on_touch_pressed(event)
			get_tree().set_input_as_handled()
		else:
			_on_touch_released(event)
			get_tree().set_input_as_handled()
	if event is InputEventScreenDrag:
		_on_touch_drag(event)
		get_tree().set_input_as_handled()


func _on_touch_pressed(event: InputEventScreenTouch):
	pass


func _on_touch_released(event: InputEventScreenTouch):
	launch_projectile(current_projectile, launch_force)
	$ReloadTimer.start()
	launch_force = Vector2()


func _on_touch_drag(event: InputEventScreenDrag):
	launch_force = (rest.global_position - event.position).clamped(MAX_DISTANCE)
	current_projectile.position = rest.global_position - launch_force


func _on_ReloadTimer_timeout():
	load_projectile()
