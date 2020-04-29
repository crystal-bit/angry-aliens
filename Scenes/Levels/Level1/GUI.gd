extends CanvasLayer

onready var vs = get_viewport().size
onready var score := $Score


func _ready():
	$TouchScreenButton.position = Vector2(32, 20)
	score.score_value = 0
	score.scale = Vector2(0.4, 0.4)
	score.grow_direction = "left"
	get_tree().connect("screen_resized", self, "_on_screen_resized")
	_on_screen_resized()


func _on_Scores_points_gained(new_points):
	score.increase(new_points)
	score.appear_animation()


func _on_screen_resized():
	vs = get_viewport().get_visible_rect()
	score.position = Vector2(vs.size.x - 32, 32)
