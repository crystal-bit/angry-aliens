extends CanvasLayer

onready var vs = get_viewport().size


func _ready():
	$TouchScreenButton.position = Vector2(32, 20)
	$Score.score_value = 0
	get_tree().connect("screen_resized", self, "_on_screen_resized")
	_on_screen_resized()


func _on_Scores_points_gained(new_points):
	$Score.increase(new_points)
	$Score.appear_animation()


func _on_screen_resized():
	vs = get_viewport().get_visible_rect()
	$Score.position = Vector2(vs.size.x - 32, 32)
