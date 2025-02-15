extends Area2D

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
	pass

func kill_player():
	print('IM KILLING YOU >:((')
	for area in get_overlapping_areas():
		area._on_timer_timeout()
