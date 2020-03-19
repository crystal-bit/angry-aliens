extends Node2D

onready var slingshot = 0

export var debug_move_with_wasd = true

var speed = 500
var clamping = true

func _ready():
	set_process(debug_move_with_wasd)
	
	
func _process(delta):
	if Input.is_action_pressed("ui_left"):
		position.x -= speed * delta
	if Input.is_action_pressed("ui_right"):
		position.x += speed * delta
	if Input.is_action_pressed("ui_up"):
		position.y -= speed * delta
	if Input.is_action_pressed("ui_down"):
		position.y += speed * delta
#	if Input.is_action_just_pressed("ui_select"):
#		clamping = !clamping
	if clamping:
		clamp_into_camera_limits()
	

func clamp_into_camera_limits():
#	print($Camera2D.get_canvas_transform().xform(Vector2($Camera2D.limit_left, $Camera2D.limit_top)))
	var vws = $Camera2D.get_viewport().get_visible_rect().size * $Camera2D.zoom
	
	position.x = clamp(position.x, 
		$Camera2D.limit_left + vws.x / 2, 
		$Camera2D.limit_right - vws.x / 2
	)	
	position.y = clamp(position.y, 
		$Camera2D.limit_top + vws.y / 2, 
		$Camera2D.limit_bottom - vws.y / 2
	)
