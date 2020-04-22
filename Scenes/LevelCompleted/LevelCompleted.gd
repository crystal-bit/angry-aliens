extends Control

onready var score = $NinePatchRect/ScoreWrapper/Score
onready var retry_button = $NinePatchRect/RetryButtonWrapper/RetryButton


func _ready():
	pass


func appear(final_score: int):
	score.score_value = final_score
	$AnimationPlayer.play("show")
	yield($AnimationPlayer, "animation_finished")
	# activate button
	retry_button.connect("released", self,  "_on_Retry_released")


func _animate_score():
	score.appear_animation()


func _on_Retry_released():
	get_tree().reload_current_scene()
