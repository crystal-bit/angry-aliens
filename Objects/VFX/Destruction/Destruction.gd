extends AnimatedSprite


func _ready():
	pass # Replace with function body.



func _on_AnimatedSprite_animation_finished():
	var t = Tween.new()
	add_child(t)
	t.interpolate_property(self, "modulate:a", self.modulate.a, 0, 1, Tween.TRANS_EXPO, Tween.EASE_OUT)
	t.start()
	playing = false
