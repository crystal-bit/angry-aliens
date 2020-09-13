extends ColorRect

onready var aliens = $Aliens
onready var metal_box = $MetalBox
onready var tween = $Tween
onready var timer = $Timer
onready var ground_hit = $Audio/HitSound


func _ready():
	randomize()
	$Title/AnimationPlayer.play("appear")


func _on_About_pressed():
	Globals.goto_scene("res://Scenes/MainMenu/AboutScreen/AboutScreen.tscn")


func _on_Exit_pressed():
	get_tree().quit()


func _on_Play_pressed():
	Globals.goto_scene("res://Scenes/Levels/LevelBase/LevelBase.tscn", { 'level': 3 })


func _shake_cbk(amnt):
	var random_dir = Vector2(randf() - 0.5, randf() - 0.5).normalized() * amnt
	rect_position.x = random_dir.x
	rect_position.y = random_dir.y


func shake():
	tween.interpolate_method(self,
		"_shake_cbk",
		2.6,
		0,
		0.25,
		Tween.TRANS_CIRC,
		Tween.EASE_IN_OUT
	)
	tween.start()


func launch_aliens():
	for alien in aliens.get_children():
		var random_vec = Vector2(randf() - 0.5, -1).normalized()
		alien.mode = RigidBody2D.MODE_RIGID
		alien.apply_central_impulse(random_vec * 550)
		alien.apply_torque_impulse((randf() - 0.5) * 3000)
	timer.start()


func show_secret_weight():
	var ap := $MetalBox/AnimationPlayer
	metal_box.modulate.a = 0
	metal_box.rect_position.y = $VBoxContainer.rect_position.y
	ap.play("appear")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "appear":
		shake()
		$VBoxContainer/Play/AnimationPlayer.play("idle")
		launch_aliens()


func _on_MetalBox_pressed():
	# launch metal box
	var t = metal_box.get_node("Tween")
	if t.is_active():
		return
	t.interpolate_property(metal_box, "rect_position:y", metal_box.rect_position.y, 800, 1, Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	t.start()
	t.connect("tween_completed", self, "_on_metal_box_tween_completed")


func _on_metal_box_tween_completed(a, b):
	launch_aliens()
	ground_hit.pitch_scale = 0.7
	ground_hit.play()



func _on_Timer_timeout():
	show_secret_weight()
