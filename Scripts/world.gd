extends Node2D

@export var level = 0

var stats = PlayerStats

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match level:
		0:
			stats.screens_needed = 1
		1:
			stats.screens_needed = 3
		2: 
			stats.screens_needed = 8
			$WindowScreen2.deactivate()
			$WindowScreen3.deactivate()
		3:
			pass
		4:
			pass
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
			print(stats.screens_needed, "and", stats.screens)
			if stats.screens >= 1 and stats.screens < 3:
				$WindowScreen2.activate()
				$WindowScreen3.activate()
		3:
			pass
		4:
			pass

func level_complete():
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://Scenes/level_complete.tscn")
