extends Node2D

@export var level = 0

var screen1
var screen2
var screen3
var screen4
var screen5
var screen6
var screen7
var screen8
var stats = PlayerStats

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match level:
		0:
			stats.screens_needed = 1
			stats.level = 0
		1:
			stats.screens_needed = 1
			stats.level = 1
		2: 
			stats.screens_needed = 4
			stats.level = 2
			screen2 = $WindowScreen2
			screen3 = $WindowScreen3
			screen4 = $WindowScreen4
			screen2.deactivate()
			screen3.deactivate()
			screen4.deactivate()
		3:
			stats.screens_needed = 2
			stats.level = 3
		4:
			stats.screens_needed = 8
			stats.level = 4
			screen2 = $WindowScreen2
			screen3 = $WindowScreen3
			screen4 = $WindowScreen4
	stats.screens = 0
	stats.all_screens_charged.connect(level_complete)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match level:
		0:
			pass
		1:
			pass
		2: 
			if stats.screens >= 1 and stats.screens < 3:
				if screen2 != null:
					screen2.activate()
				if screen3 != null:
					screen3.activate()
			if stats.screens >= 3:
				if screen4 != null:
					screen4.activate()
		3:
			pass
		4:
			pass

func level_complete():
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://Scenes/level_complete.tscn")
