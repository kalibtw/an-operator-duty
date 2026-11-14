extends PopupPanel

signal player_confirmed_launch

func _on_no_button_pressed() -> void:
	hide()

func _on_yes_button_pressed() -> void:
	player_confirmed_launch.emit()
	hide()
