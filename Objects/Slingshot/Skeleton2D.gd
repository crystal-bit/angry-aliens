extends Skeleton2D


onready var tween = $Tween
onready var control_bone = $Bone1/Bone2


func release_animation():
	tween.interpolate_property(control_bone,
		"position",
		control_bone.position,
		control_bone.rest_position,
		0.38, # sec
		Tween.TRANS_BOUNCE,
		Tween.EASE_OUT
	)
	tween.start()


func _on_InputArea_slingshot_released():
	release_animation()
