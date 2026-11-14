extends Node2D

@onready var Moon = $"CanvasLayer/MarginContainer/HBoxContainer/Moon&Resources&Missions/Moon&Resources/MoonPlace/SubViewport/Moon"
@onready var popup_panel: PopupPanel = $CanvasLayer/PopupPanel
@onready var upgrades: VBoxContainer = $"CanvasLayer/MarginContainer/HBoxContainer/Rocket&Upgrades/UpgradeList/Upgrades"

var upgrade : PackedScene = load("res://scenes/upgrade.tscn")

func _ready() -> void:
	Moon.ask_to_launch.connect(_on_ask_to_launch)
	popup_panel.player_confirmed_launch.connect(_on_player_confirmed_launch)
	
func _on_ask_to_launch() -> void:
	popup_panel.popup_centered()
	popup_panel.visible = true
	
func _on_player_confirmed_launch() -> void:
	Moon.confirm_pending_mission()
	popup_panel.hide()
