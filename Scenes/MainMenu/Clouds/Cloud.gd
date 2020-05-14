extends Node2D

var alien_textures = [
	"res://Assets/graphics/kenney_physicsAssets_v2/PNG/Aliens/alienBeige_round.png",
	"res://Assets/graphics/kenney_physicsAssets_v2/PNG/Aliens/alienBlue_round.png",
	"res://Assets/graphics/kenney_physicsAssets_v2/PNG/Aliens/alienGreen_round.png",
	"res://Assets/graphics/kenney_physicsAssets_v2/PNG/Aliens/alienPink_round.png",
	"res://Assets/graphics/kenney_physicsAssets_v2/PNG/Aliens/alienYellow_round.png"
]

var cloud_textures = []

onready var alien := $AlienAnim


func _ready():
	pass

func ignored():
	alien.texture = load(alien_textures[randi() % alien_textures.size()])
	alien.scale *= min(scale.x, scale.y)
	$CloudSprite.scale *= scale
	var sprite_size = $CloudSprite.scale * $CloudSprite.texture.get_size()
	if name == "Cloud":
		print(sprite_size)
		print(-sprite_size.y / 2 - 1)

	var overshoot = 20
	# update animation
	var anim: Animation = $AlienAnim/AnimationPlayer.get_animation("appear")
	var track = anim.track_get_path(0) # y_position_anim
	anim.track_set_key_value(0, 0, 0)
	anim.track_set_key_value(0, 1, -sprite_size.y / 2 - overshoot)
	anim.track_set_key_value(0, 2, -sprite_size.y / 2)
	anim.track_set_key_value(0, 3, -sprite_size.y / 2)
	anim.track_set_key_value(0, 4, -sprite_size.y / 2 - overshoot)
	if name == "Cloud":
		anim.track_set_key_value(0, 3, 70)
	anim.track_set_key_value(0, 5, 0)
	$AlienAnim/AnimationPlayer.add_animation("programmatic_appear", anim)
	scale = Vector2(1, 1)


func show_alien():
	$AlienAnim/AnimationPlayer.play("programmatic_appear")

