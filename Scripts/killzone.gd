extends Area2D

@export var shader_material: ShaderMaterial  # Assign this in the editor
@export var timer: float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#var kill = Animation.new()
	#kill.length = timer
	#kill.loop_mode = 1
	#kill.add_track(Animation.TYPE_ANIMATION,0)
	

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

func kill():
	print('IM KILLING YOU >:((')
