extends Area3D

signal selected(marker)

@export var mission_name: String = "Mission 0"

func _ready() -> void:
	input_ray_pickable = true
	input_event.connect(_on_input_event)

func _on_input_event(
	_camera: Camera3D,
	event: InputEvent,
	_event_position: Vector3,
	_normal: Vector3,
	_shape_idx: int
) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			selected.emit(self)
