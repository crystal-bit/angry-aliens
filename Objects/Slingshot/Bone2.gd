extends Bone2D
tool

onready var rest_position = Vector2(60, 0)


func _ready():
	position = rest_position


func _process(delta: float) -> void:
	scale.y = 0.7 / (1 +log(0.01 * position.x))
	if abs(scale.y) > 1:
		scale.y = 1
