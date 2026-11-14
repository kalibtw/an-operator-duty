extends Node3D

signal ask_to_launch

var dragging := false
var last_mouse_position := Vector2.ZERO
var rotation_speed := 0.01
var rotation_speed_sun := 0.5

@export var mission_marker_scene: PackedScene

var mission_markers: Array[Node3D] = []

var pending_position: Vector3
var pending_normal: Vector3
var has_pending_mission := false

func try_rotating(event: InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			dragging = event.pressed

	if event is InputEventMouseMotion and dragging:
		rotate_y(
			(event.position.x - last_mouse_position.x)
			* rotation_speed
		)

		rotate_x(
			(event.position.y - last_mouse_position.y)
			* rotation_speed
		)

	if event is InputEventMouseMotion:
		last_mouse_position = event.position


func _input(event: InputEvent):
	try_rotating(event)

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			check_moon_click(event.position)


func check_moon_click(mouse_position: Vector2):
	var camera = get_viewport().get_camera_3d()
	
	if camera == null:
		return
	
	var ray_origin = camera.project_ray_origin(mouse_position)
	var ray_direction = camera.project_ray_normal(mouse_position)
	
	var query = PhysicsRayQueryParameters3D.create(
		ray_origin,
		ray_origin + ray_direction * 1000
	)
	
	query.collision_mask = 1
	
	var result = get_world_3d().direct_space_state.intersect_ray(query)
	
	if result and result.collider == $StaticBody3D:
		pending_position = to_local(result.position)
		pending_normal = (global_transform.basis.transposed() * result.normal).normalized()
		has_pending_mission = true
		
		ask_to_launch.emit()
		
	if result:
		if result.collider.is_in_group("moon_clickable"):
			ask_to_launch.emit()

func confirm_pending_mission():
	if not has_pending_mission:
		return
	
	var marker = mission_marker_scene.instantiate()
	
	add_child(marker)
	
	marker.position = pending_position + pending_normal * 0.02
	
	var up = pending_normal.normalized()
	var x_axis = up.cross(Vector3.FORWARD)
	
	if x_axis.length_squared() < 0.001:
		x_axis = up.cross(Vector3.RIGHT)
	
	x_axis = x_axis.normalized()
	var z_axis = x_axis.cross(up).normalized()
	
	marker.basis = Basis(x_axis, up, z_axis)
	
	marker.selected.connect(_on_marker_selected)
	
	mission_markers.append(marker)
	
	has_pending_mission = false


func _on_marker_selected(marker: Node3D):
	print("Selected mission: ", marker.mission_name)
