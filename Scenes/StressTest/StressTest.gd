extends Node2D


func _ready() -> void:
	pass # Replace with function body.

var elapsed = 0
var enemies_count = 3
var spawn_rate = 0.2

func _process(delta: float) -> void:
	elapsed += delta

	if elapsed > spawn_rate:
		elapsed = 0
		var new_enemy = $Enemy.duplicate()
		new_enemy.position.x = rand_range(0, 500)
		new_enemy.position.y = -50
		add_child(new_enemy)
		enemies_count +=1

		if enemies_count == 20:
			spawn_rate = 0.05

		print("Enemies ", enemies_count, " - FPS: ", Performance.get_monitor(Performance.TIME_FPS))
