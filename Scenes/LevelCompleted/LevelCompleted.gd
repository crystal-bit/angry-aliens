extends Control

onready var score := $NinePatchRect/ScoreWrapper/Score
onready var retry_button := $NinePatchRect/RetryButtonWrapper/RetryButton
onready var level_selection_button := $NinePatchRect/LevelSelectionWrapper/LevelSelection

func _ready():
	pass


func appear(final_score: int):
	score.score_value = final_score
	$AnimationPlayer.play("show")
	yield($AnimationPlayer, "animation_finished")
	# activate buttons
	retry_button.connect("released", self,  "_on_Retry_released")
	level_selection_button.connect("released", self,  "_on_LevelSelection_released")


func _animate_score():
	score.appear_animation()


func _on_LevelSelection_released():
	Globals.goto_scene("res://Scenes/Screens/ContributeScreen.tscn")


func _on_Retry_released():
	# TODO: when there will be multiple levels, remove hardcoded path.
	# Possibly move this to Globals.gd
	var current_level = "res://Scenes/Levels/Level1/Level1.tscn"
	Globals.goto_scene(current_level)
