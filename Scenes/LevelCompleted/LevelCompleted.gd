extends Control

onready var score = $NinePatchRect/ScoreWrapper/Score


func _ready():
	$ColorRect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	#appear(2300)


func appear(final_score: int):
	score.score_value = final_score
	$AnimationPlayer.play("show")


func _animate_score():
	score.appear_animation()


func _on_Retry_released():
	get_tree().reload_current_scene()
