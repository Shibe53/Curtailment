extends CharacterBody2D

enum {
	MOVE
}

@export var SPEED = 80

var state = MOVE
var rng = RandomNumberGenerator.new()
var impulse:Vector2 = Vector2(SPEED, SPEED)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	match state:
		MOVE:
			move_state(delta)

func move_state(delta):
	if get_last_slide_collision():
		var collision:KinematicCollision2D = get_last_slide_collision()
		impulse = impulse.bounce(collision.get_normal())
	
	velocity = impulse
	move_and_slide()
