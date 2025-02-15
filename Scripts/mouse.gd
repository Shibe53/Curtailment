extends Area2D

var velocity: Vector2
const FRICTION = 0.98

@onready var sprite_2d = $Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2(0,0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity*delta
	velocity = (velocity + get_local_mouse_position()*delta*4)*FRICTION
	
	sprite_2d.rotation = velocity.angle()
	#velocity = velocity*(1-delta) + get_local_mouse_position()*delta*3
	
	#var p2 = get_local_mouse_position()/2 + velocity.project(get_local_mouse_position().orthogonal())
	#velocity = velocity*(1-delta) + p2*delta
	#velocity += position.bezier_derivative(p2, p2, get_global_mouse_position(), 0)*delta

func _on_area_2d_area_entered(area: Area2D) -> void:
	visible = true


func _on_area_2d_area_exited(area: Area2D) -> void:
	visible = false
