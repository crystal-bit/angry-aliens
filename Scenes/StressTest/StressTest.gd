extends Node2D

var enemy_scene = load("res://Objects/Enemy/Enemy.tscn")

var frames = 0
var seconds = 0


func _ready():
	var t: Timer = Timer.new()
	add_child(t)
	t.connect("timeout", self, "each_second")
	t.start()


func each_second():
	seconds += 1
	frames += Performance.get_monitor(Performance.TIME_FPS) / 1000
	print("Frames = ", frames, "k")
	print("Avg = ", frames / seconds * 1000)
	if seconds == 40:
		breakpoint



func _on_SpawnTimer_timeout():
	var enemy_node = enemy_scene.instance()
	enemy_node.position = Vector2(rand_range(0, 1000), -100)
	add_child(enemy_node)
