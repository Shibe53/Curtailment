extends Area2D

@export var shader_material: ShaderMaterial  # Assign this in the editor
@export_range(2,10) var timer: float
@onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.speed_scale = 3/timer
	#var kill = Animation.new()
	#kill.length = timer
	#kill.loop_mode = 1
	#
	#kill.add_track(Animation.TYPE_VALUE,0)
	#kill.track_set_path(0, "Sprite2D:modulate")
	#
	#kill.track_insert_key(0, 0, Color(255,0,0,0))
	#kill.track_insert_key(0, timer-0.4, Color(255,0,0,0))
	#kill.track_insert_key(0, timer-0.3, Color(255,0,0,169))
	#
	#kill.add_track(Animation.TYPE_METHOD,1)
	#kill.track_set_path(1, ".")
	#
	#kill.track_insert_key(1,timer-0.3,kill_player)
	#
	#animation_player.get_animation_library("").add_animation("kill",kill)
	#animation_player.play("kill")

func _process(delta):
	var rat = get_node_or_null("../../Mouse/Sprite2D")
	if shader_material:
		var mask_pos = global_position
		var sprite_pos = rat.global_position

		# Convert to local space (relative to Sprite2D)
		var local_mask_pos = (mask_pos - sprite_pos) / rat.scale  
		var uv_mask_pos = local_mask_pos

		# Get Area2D's dimensions (assuming CollisionShape2D with a rectangle)
		var shape = $CollisionShape2D.shape
		var mask_size = shape.extents * 2.0  # Full width & height
		var uv_mask_size = mask_size

		shader_material.set_shader_parameter("mask_position", uv_mask_pos)
		shader_material.set_shader_parameter("mask_size", uv_mask_size)  # Pass size

func kill_player():
	print('IM KILLING YOU >:((')
	if has_overlapping_areas():
		print('L')
