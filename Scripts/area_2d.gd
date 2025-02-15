extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_entered(area):
	if area.is_in_group("visibility_trigger"):
		area.visible = true  # Show the node

func _on_area_exited(area):
	if area.is_in_group("visibility_trigger"):
		area.visible = false  # Hide the node
