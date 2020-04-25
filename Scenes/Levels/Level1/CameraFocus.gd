extends Node2D

onready var slingshot = get_parent().get_node("Slingshot")
onready var camera := $Camera2D
onready var tween := $Tween

export(float, 0.1, 3) var zoom = 1 setget set_zoom
export var debug_move_with_wasd = true

var dbg_speed = 500
var clamping = true

var follow_target: Node2D
var zoom_max
var zoom_min
var zoom_default
var focus_default_position # global


func _ready():
	set_zoom(zoom)
	focus_default_position = self.global_position
	zoom_default = camera.zoom
	zoom_max = camera.zoom - 0.15 * Vector2(1, 1)
	zoom_min = camera.zoom + 0.2 * Vector2(1, 1)


func zoom_out_anim():
	tween.interpolate_property(
		camera,
		"zoom",
		camera.zoom,
		zoom_min,
		.6,
		Tween.TRANS_CUBIC,
		Tween.EASE_OUT
	)
	tween.start()


func zoom_in_anim(target_global_position):
	tween.interpolate_property(
		camera,
		"zoom",
		camera.zoom,
		zoom_max,
		1.0,
		Tween.TRANS_QUAD,
		Tween.EASE_IN_OUT
	)
	tween.start()


func reset_zoom_anim():
	tween.interpolate_property(
		camera,
		"zoom",
		camera.zoom,
		zoom_default,
		1.2,
		Tween.TRANS_QUAD,
		Tween.EASE_IN_OUT
	)
	tween.interpolate_property(
		self,
		"global_position",
		global_position,
		focus_default_position,
		0.6,
		Tween.TRANS_QUAD,
		Tween.EASE_IN_OUT
	)
	tween.start()


func follow(target: Node2D):
	follow_target = target


func _process(delta):
	if debug_move_with_wasd:
		if Input.is_action_pressed("ui_left"):
			position.x -= dbg_speed * delta
		if Input.is_action_pressed("ui_right"):
			position.x += dbg_speed * delta
		if Input.is_action_pressed("ui_up"):
			position.y -= dbg_speed * delta
		if Input.is_action_pressed("ui_down"):
			position.y += dbg_speed * delta
	#	if Input.is_action_just_pressed("ui_select"):
	#		clamping = !clamping
	if follow_target:
		if follow_target.global_position.x > global_position.x:
			global_position.x = follow_target.global_position.x
		if follow_target.global_position.y < global_position.y:
			global_position.y = follow_target.global_position.y

	if clamping:
		clamp_into_camera_limits()


func set_zoom(val):
	zoom = val
	if find_node("Camera2D"):
		camera.set_zoom(Vector2(val, val))


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


func _unhandled_input(event):
	# if user is aiming with the slinshot
	if slingshot.state == slingshot.States.AIMING:
		zoom_out_anim()
		# don't move the camera
		return

	if event is InputEventScreenDrag:
		position.x -= event.relative.x * $Camera2D.zoom.x
		get_tree().set_input_as_handled()


func _on_Slingshot_projectile_launched(projectile: Projectile):
	zoom_in_anim(projectile.global_position)
	follow(projectile)
	projectile.connect("almost_stopped", self, "_on_projectile_almost_stopped")


func _on_projectile_almost_stopped():
	follow_target = null
	reset_zoom_anim()
