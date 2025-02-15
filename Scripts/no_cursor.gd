extends Area2D

@export var shader_material: ShaderMaterial  # Assign this in the editor
@onready var collision_shape_2d = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	pass
	
func _on_mouse_entered():
	collision_shape_2d.shape
	get_local_mouse_position()
