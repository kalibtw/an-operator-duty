extends Control

@onready var resolution_option: OptionButton = $HBoxContainer/VBoxContainer/ResolutionOption

func add_resolutions():
	for r in Gui.resolutions.keys():
		resolution_option.add_item(r)

func _ready() -> void:
	add_resolutions()

func update_button_values():
	var window_size_string = str(get_window().size.x, "x", get_window().size.y)
	var resolution_index = Gui.resolutions.keys().find(window_size_string)
	resolution_option.selected = resolution_index

func _on_resolution_option_item_selected(index: int) -> void:
	var key = resolution_option.get_item_text(index)
	var new_resolution: Vector2i = Gui.resolutions[key]
	var window = get_window()
	window.size = new_resolution
	Gui.center_window()


func _on_exit_button_options_pressed() -> void:
	get_tree().free()
