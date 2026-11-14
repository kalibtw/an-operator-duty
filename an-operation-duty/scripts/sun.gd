extends Node3D

var rotation_speed_sun := 0.05

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate_y(rotation_speed_sun * delta)
