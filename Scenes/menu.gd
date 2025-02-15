extends Control

var stats = PlayerStats

func _on_button_pressed() -> void:
	match stats.level:
		-1:
			get_tree().change_scene_to_file("res://Scenes/Levels/tutorial_level.tscn")
		0:
			get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")
		1:
			get_tree().change_scene_to_file("res://Scenes/Levels/level_2.tscn")
		2: 
			get_tree().change_scene_to_file("res://Scenes/Levels/level_3.tscn")
		3:
			get_tree().change_scene_to_file("res://Scenes/Levels/level_4.tscn")
		4:
			pass
