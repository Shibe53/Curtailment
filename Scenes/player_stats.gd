extends Node

signal all_screens_charged

@export var level = 0:
	set(value):
		level = value

@export var screens_needed = 10:
	set(value):
		screens_needed = value

@export var screens = 0:
	set(value):
		screens = value
		if screens >= screens_needed:
			emit_signal("all_screens_charged")
