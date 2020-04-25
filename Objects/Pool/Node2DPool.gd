extends Node
class_name Node2DPool

# Needs to have a `can_be_pooled` property, otherwise the pool
# won't work
export(PackedScene) var object_scene

var pool_size := 5
var pool_refresh_timer := 1

var active_objs
var inactive_objs


func _init():
	# create Active container
	active_objs = Node.new()
	active_objs.name = "ActiveObjs"
	add_child(active_objs)
	# create Inactive container
	inactive_objs = Node.new()
	inactive_objs.name = "InactiveObjs"
	add_child(inactive_objs)


func _ready():
	# Populate pool
	for i in range(pool_size):
		inactive_objs.add_child(_create_obj())
	# schedule pool refresh
	var timer := Timer.new()
	timer.wait_time = pool_refresh_timer
	add_child(timer)
	timer.start()
	timer.connect("timeout", self, "check_unused_objs")


func get_instance():
	var obj = inactive_objs.get_child(0)
	# if no obj found in the pool
	if obj == null:
		print("Pool: EMPTY. Creating new object.")
		obj = _create_obj()
	else:
		inactive_objs.remove_child(obj)
	obj.modulate.a = 1
	active_objs.add_child(obj)
	return obj


func check_unused_objs():
	for obj in active_objs.get_children():
		if obj.can_be_pooled:
			# move object to inactive pool
			active_objs.remove_child(obj)
			inactive_objs.add_child(obj)


func _create_obj() -> PoolableNode2D:
	var obj = object_scene.instance()
	obj.modulate.a = 0
	if !obj is PoolableNode2D:
		print("WARNING:, ", obj, " does not extend PoolableNode2D")
	return obj


func _on_score_hidden_remove_score(score):
	score.queue_free()


func _print_stats():
	print("size:      ", active_objs.get_child_count() + inactive_objs.get_child_count())
	print("active:    ", active_objs.get_child_count())
	print("inactive:  ", inactive_objs.get_child_count())
