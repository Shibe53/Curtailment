extends Area2D

var velocity: Vector2
var timer := Timer.new()
const FRICTION = 0.98
var fade_duration = 0.05

var stats = PlayerStats
@onready var sprite_2d = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2(0,0)
	add_child(timer)
	timer.wait_time = 5.0
	timer.one_shot = true;
	timer.timeout.connect(_on_timer_timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity*delta
	velocity = (velocity + get_local_mouse_position()*delta*4)*FRICTION
	
	sprite_2d.rotation = velocity.angle()
	
	for area in get_overlapping_bodies():
		area.charging()
	#velocity = velocity*(1-delta) + get_local_mouse_position()*delta*3
	
	#var p2 = get_local_mouse_position()/2 + velocity.project(get_local_mouse_position().orthogonal())
	#velocity = velocity*(1-delta) + p2*delta
	#velocity += position.bezier_derivative(p2, p2, get_global_mouse_position(), 0)*delta


func _on_area_2d_area_exited(area: Area2D) -> void:
	timer.start()
	fade_out()

func fade_out():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0.0, fade_duration)  # Fade out

func _on_timer_timeout() -> void:
	queue_free()
	get_tree().change_scene_to_file("res://Scenes/game_over.tscn")

func _on_area_2d_area_entered(area: Area2D) -> void:
	timer.stop()
	fade_in()
	
func fade_in():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 1.0, fade_duration)  # Fade in
