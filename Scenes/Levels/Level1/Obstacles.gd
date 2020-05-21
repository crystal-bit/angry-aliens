extends Node

export(NodePath) var particles_manager_path
onready var particles_manager = get_node(particles_manager_path)

onready var audio = get_parent().get_node("Audio")

func _ready():
	for obstacle in get_children():
		obstacle.connect("hit", audio, "_on_Obstacle_hit")
		if obstacle is StoneObstacle:
			obstacle.connect("hit", particles_manager, "_on_Obstacle_hit")

