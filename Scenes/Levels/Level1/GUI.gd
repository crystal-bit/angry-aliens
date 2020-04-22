extends CanvasLayer

onready var vs = get_node("/root").get_size()


func _ready():
	$TouchScreenButton.position = Vector2(32, 20)
	$Score.position = Vector2(vs.x - 32, 32)
	$Score.score_value = 0


func _on_Scores_points_gained(new_points):
	$Score.increase(new_points)
	$Score.appear_animation()
