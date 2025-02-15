extends Area2D

var velocity: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2(0,0)
	position.x = 50
	position.y = 50


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity*delta
	velocity = velocity*(1-delta) + get_local_mouse_position()*delta*3


func _on_area_2d_area_entered(area: Area2D) -> void:
	visible = true


func _on_area_2d_area_exited(area: Area2D) -> void:
	visible = false
