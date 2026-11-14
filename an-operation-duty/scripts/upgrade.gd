extends HBoxContainer

@onready var upgrade_icon: TextureRect = $UpgradeIcon
var arrows = [
	preload("res://assets/Upg_Idle.png"),
	preload("res://assets/Upg_Hover.png")
]

func _ready() -> void:
	upgrade_icon.texture = arrows[0]
	
func _on_mouse_entered() -> void:
	upgrade_icon.texture = arrows[1]

func _on_mouse_exited() -> void:
	upgrade_icon.texture = arrows[0]
