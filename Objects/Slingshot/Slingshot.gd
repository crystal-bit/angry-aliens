extends Node2D
tool

export(NodePath) var projectile_path

onready var projectile: RigidBody2D = get_node(projectile_path)
onready var control_bone = $Skeleton2D/Bone1/Bone2
onready var rest_position = $RestPosition # used also to calculate the launch vector
onready var trajectory_drawer = $TrajectoryDrawer

export var slingshot_elastic_force = 4
var launch_impulse = Vector2(0, 0)  # impulse (kg*m / s) - https://en.wikipedia.org/wiki/Impulse_(physics)

enum States {
	IDLE,
	GRABBED,
	PROJECTILE_MOVING
}

var state = States.IDLE


func _ready():
	projectile.mode = RigidBody2D.MODE_KINEMATIC
	projectile.position = rest_position.global_position


func _get_configuration_warning():
	var msg = ""
	if (not projectile_path) or (not projectile is RigidBody2D):
		msg = "Slingshot node needs a RigidBody2D to be set in Projectile Path"
	return msg


func _physics_process(delta):
	if state == States.GRABBED:
		deform_skeleton_mesh()
		update_launch_impulse()
		trajectory_drawer.draw_trajectory(
			launch_impulse / projectile.mass, # velocity (m/s)
			projectile.position, 
			projectile.gravity_scale * ProjectSettings.get("physics/2d/default_gravity")
		)
	if state == States.PROJECTILE_MOVING:
		if projectile.linear_velocity.length() < 15:
			state = States.IDLE
			# TODO reset projectile


func deform_skeleton_mesh():
	var gm_pos = get_global_mouse_position()
	if gm_pos.x < $Skeleton2D/Bone1.global_position.x - 50:
		control_bone.global_position = gm_pos + Vector2(25, 0)

func update_launch_impulse():
	launch_impulse = slingshot_elastic_force * (rest_position.global_position - projectile.global_position)


func launch(launch_impulse: Vector2):
	if !projectile:
		return
	projectile.mode = RigidBody2D.MODE_RIGID
#	projectile.global_position = control_bone.global_position
	projectile.apply_impulse(Vector2(), launch_impulse)


func _on_InputArea_slingshot_grabbed():
	if state == States.IDLE:
		state = States.GRABBED
		set_physics_process(true)


func _on_InputArea_slingshot_released():
	if state == States.GRABBED:
		state = States.PROJECTILE_MOVING
		launch(launch_impulse)
		trajectory_drawer.clear()


func _on_InputArea_slingshot_moved(slingshot_pos):
	projectile.global_position = slingshot_pos - get_viewport_transform().get_origin()
