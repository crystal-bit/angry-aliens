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
	Globals.goto_scene("res://Scenes/Levels/LevelBase/LevelBase.tscn", {'level': Globals.current_level_index})


func _on_LevelSelection_pressed():
	Globals.goto_scene("res://Scenes/LevelSelection/LevelSelection.tscn")
