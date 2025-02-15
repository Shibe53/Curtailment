extends Control

var stats = PlayerStats

func _on_button_pressed() -> void:
	if stats.screens >= stats.screens_needed:
		stats.level += 1
	
	match stats.level:
		0:
			get_tree().change_scene_to_file("res://Scenes/Levels/level_3.tscn")
		1:
			get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")
		2:
			get_tree().change_scene_to_file("res://Scenes/Levels/level_2.tscn")
		3: 
			get_tree().change_scene_to_file("res://Scenes/Levels/level_3.tscn")
		4:
			get_tree().change_scene_to_file("res://Scenes/Levels/level_4.tscn")
		5:
			pass
