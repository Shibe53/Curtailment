extends Node2D

var stats = PlayerStats

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().get_root().set_transparent_background(true)
	stats.screens_needed = 1
	stats.screens = 0
	stats.all_screens_charged.connect(level_complete)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func level_complete():
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://Scenes/level_complete.tscn")
