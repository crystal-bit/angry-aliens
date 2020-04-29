extends Node
class_name Node2DPool

# Needs to have a `can_be_pooled` property, otherwise the pool
# won't work
export(PackedScene) var object_scene

var pool_size := 5
var pool_refresh_timer := 1

var active_objs := []
var inactive_nodes_container: Node


func _init():
	inactive_nodes_container = Node.new()
	inactive_nodes_container.name = "InactiveNodes"
	add_child(inactive_nodes_container)


func _ready():
	# Populate pool
	for i in range(pool_size):
		var obj = _create_obj()
		inactive_nodes_container.add_child(obj)
	# schedule pool refresh
	var timer := Timer.new()
	timer.wait_time = pool_refresh_timer
	add_child(timer)
	timer.start()
	timer.connect("timeout", self, "check_unused_objs")


func _exit_tree():
	if "pools" in get_groups():
		for obj in inactive_nodes_container.get_children():
			obj.queue_free()
		for obj in active_objs:
			obj.queue_free()


func pool(obj):
	var parent = obj.get_parent()
	parent.remove_child(obj)
	active_objs.erase(obj)
	obj.modulate.a = 0
	obj.can_be_pooled = false
	inactive_nodes_container.add_child(obj)


func get_instance():
	var obj
	if inactive_nodes_container.get_child_count() > 0:
		obj = inactive_nodes_container.get_child(0)
		inactive_nodes_container.remove_child(obj)
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
	var obj = object_scene.instance() as PoolableNode2D
	obj.modulate.a = 0
	if !obj is PoolableNode2D:
		print("WARNING:, ", obj, " does not extend PoolableNode2D")
	return obj


func _print_stats():
	print('---')
	print("size:      ", len(active_objs) + inactive_nodes_container.get_child_count())
	print("active:    ", len(active_objs))
	print("inactive:  ", inactive_nodes_container.get_child_count())
