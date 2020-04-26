extends Node
class_name Node2DPool

# Needs to have a `can_be_pooled` property, otherwise the pool
# won't work
export(PackedScene) var object_scene

var pool_size := 5
var pool_refresh_timer := 1

var active_objs := []
var inactive_objs := []


func _ready():
	# Populate pool
	for i in range(pool_size):
		inactive_objs.append(_create_obj())
	# schedule pool refresh
	var timer := Timer.new()
	timer.wait_time = pool_refresh_timer
	add_child(timer)
	timer.start()
	timer.connect("timeout", self, "check_unused_objs")


func pool(obj):
	active_objs.erase(obj)
	var parent = obj.get_parent()
	parent.remove_child(obj)
	obj.modulate.a = 0
	obj.can_be_pooled = false
	inactive_objs.append(obj)


func get_instance():
	var obj
	if len(inactive_objs) > 0:
		obj = inactive_objs[0]
		inactive_objs.erase(obj)
	else:
		print("Pool: EMPTY. Creating new object.")
		obj = _create_obj()
	obj.modulate.a = 1
	active_objs.append(obj)
	return obj


func check_unused_objs():
	for obj in active_objs:
		if obj.can_be_pooled:
			pool(obj)



func _create_obj() -> PoolableNode2D:
	var obj = object_scene.instance()
	obj.modulate.a = 0
	if !obj is PoolableNode2D:
		print("WARNING:, ", obj, " does not extend PoolableNode2D")
	return obj


func _on_score_hidden_remove_score(score):
	score.queue_free()


func _print_stats():
	print("size:      ", active_objs.size() + inactive_objs.size())
	print("active:    ", active_objs.size())
	print("inactive:  ", inactive_objs.size())
