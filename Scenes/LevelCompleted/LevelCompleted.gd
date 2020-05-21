extends Control

onready var score := $NinePatchRect/ScoreWrapper/Score
onready var retry_button := $NinePatchRect/VBoxContainer/Retry
onready var level_selection_button := $NinePatchRect/VBoxContainer/LevelSelection


func _ready():
	pass


func appear(final_score: int):
	score.score_value = final_score
	$AnimationPlayer.play("show")
	yield($AnimationPlayer, "animation_finished")
	# activate buttons
	retry_button.disabled = false
	level_selection_button.disabled = false


func _animate_score():
	score.appear_animation()


func _on_Retry_pressed():
	# TODO: when there will be multiple levels, remove hardcoded path.
	# Possibly move this to Globals.gd
	var current_level = "res://Scenes/Levels/Level1/Level1.tscn"
	Globals.goto_scene(current_level)


func _on_LevelSelection_pressed():
	Globals.goto_scene("res://Scenes/Screens/ContributeScreen.tscn")
