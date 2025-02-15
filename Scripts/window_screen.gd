extends CharacterBody2D

var stats = PlayerStats

enum {
	MOVE,
	COMPLETE
}

@export var SPEED = 100
@export var charge = 0

@export var ROTATION = 0
@export var STRETCH_Y = 0
@export var STRETCH_X = 0
#@export var JIGGLE = 0
# curved movement
# gravity

@onready var animation_player = $AnimationPlayer
@onready var progress_bar = $ProgressBar


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
		
		COMPLETE:
			animation_player.play("meesa_disappearin")
			var increment = true
			if increment:
				increment = false
				stats.screens += 1
				print(stats.screens)

func move_state(delta):
	if get_last_slide_collision():
		var collision:KinematicCollision2D = get_last_slide_collision()
		impulse = impulse.bounce(collision.get_normal())
		
		impulse.x = sign(impulse.x) * SPEED * rng.randf_range(0.5,2)
		impulse.y = sign(impulse.y) * SPEED * rng.randf_range(0.5,2)
		
		if rng.randi_range(1,3) == 1: ROTATION = randf_range(-1,1)
		else: ROTATION = 0
		if rng.randi_range(1,3) == 1: STRETCH_X = randf_range(-1,1)
		else: STRETCH_X = 0
		if rng.randi_range(1,3) == 1: STRETCH_Y = randf_range(-1,1)
		else: STRETCH_Y = 0
		#if rng.randi_range(1,3) == 1: JIGGLE = randf()
		#else: JIGGLE = 0
			
	rotation += ROTATION*delta
	scale.x = clamp(scale.x + STRETCH_X*delta, 0.5, 2)
	scale.y = clamp(scale.y + STRETCH_Y*delta, 0.5, 2)
	velocity = impulse
	move_and_slide()
	
func charging():
	if charge < 100:
		charge += 0.05
		progress_bar.value = charge
	else:
		state = COMPLETE 
