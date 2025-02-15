extends CharacterBody2D

const Charged = preload("res://Assets/charged.wav")

var stats = PlayerStats

enum {
	MOVE,
	COMPLETE
}

@export_group("Starting values")
@export_range(0,100) var charge = 0
@export_range(0,200) var SPEED_X = 100
@export_range(0,200) var SPEED_Y = 100
@export_range(-1,1) var ROTATION: float = 0
@export_range(-1,1) var STRETCH_Y:float = 0
@export_range(-1,1) var STRETCH_X:float = 0
@export_group("")

@export_group("Changing values")
@export var CHARGE_RATE = 0.05
@export_range(0,200) var SPEED_X_LBOUND = 100
@export_range(0,200) var SPEED_X_UBOUND = 100
@export_range(0,200) var SPEED_Y_LBOUND = 100
@export_range(0,200) var SPEED_Y_UBOUND = 100
@export_range(-1,1) var ROTATION_LEFTBOUND: float = 0
@export_range(-1,1) var ROTATION_RIGHTBOUND: float = 0
@export_range(-1,1) var STRETCH_X_LEFTBOUND:float = 0
@export_range(-1,1) var STRETCH_X_RIGHTBOUND:float = 0
@export_range(-1,1) var STRETCH_Y_LEFTBOUND:float = 0
@export_range(-1,1) var STRETCH_Y_RIGHTBOUND:float = 0
@export_group("")

@export_group("Chances")
@export_range(1,100) var CHANCE_SPEED_X_CHANGE = 1
@export_range(1,100) var CHANCE_SPEED_Y_CHANGE = 1
@export_range(1,100) var CHANCE_ROTATION_CHANGE = 1
@export_range(1,100) var CHANCE_STRETCH_X_CHANGE = 1
@export_range(1,100) var CHANCE_STRETCH_Y_CHANGE = 1
@export_group("")

#@export var JIGGLE = 0
# curved movement
# gravity

@onready var animation_player = $AnimationPlayer
@onready var progress_bar = $ProgressBar


var state = MOVE
var rng = RandomNumberGenerator.new()
var impulse:Vector2 = Vector2(SPEED_X, SPEED_Y)

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

func move_state(delta):
	if get_last_slide_collision():
		var collision:KinematicCollision2D = get_last_slide_collision()
		impulse = impulse.bounce(collision.get_normal())
				
		if rng.randi_range(1,CHANCE_SPEED_X_CHANGE) == 1: impulse.x = sign(impulse.x) * rng.randi_range(SPEED_X_LBOUND,SPEED_X_UBOUND)
		if rng.randi_range(1,CHANCE_SPEED_Y_CHANGE) == 1: impulse.y = sign(impulse.y) * rng.randi_range(SPEED_Y_LBOUND,SPEED_Y_UBOUND)
		if rng.randi_range(1,CHANCE_ROTATION_CHANGE) == 1: ROTATION = randf_range(ROTATION_LEFTBOUND,ROTATION_RIGHTBOUND)
		if rng.randi_range(1,CHANCE_STRETCH_X_CHANGE) == 1: STRETCH_X = randf_range(STRETCH_X_LEFTBOUND,STRETCH_X_RIGHTBOUND)
		if rng.randi_range(1,CHANCE_STRETCH_Y_CHANGE) == 1: STRETCH_Y = randf_range(STRETCH_Y_LEFTBOUND,STRETCH_Y_RIGHTBOUND)
			
	rotation += ROTATION*delta
	scale.x = clamp(scale.x + STRETCH_X*delta, 0.5, 2)
	scale.y = clamp(scale.y + STRETCH_Y*delta, 0.5, 2)
	velocity = impulse
	move_and_slide()
	
func charging():
	if charge < 100:
		charge += CHARGE_RATE
		progress_bar.value = charge
	else:
		state = COMPLETE
		stats.screens += 1
		$AudioStreamPlayer2D.stream = Charged
		$AudioStreamPlayer2D.play()
