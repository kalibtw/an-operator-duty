extends Control

var star_assets = [
	preload("res://assets/resources_menu/star_blue.png"),
	preload("res://assets/resources_menu/star_green.png"),
	preload("res://assets/resources_menu/star_white.png"),
	preload("res://assets/resources_menu/star_y_r.png")
]

@onready var stars: Control = $"."

@onready var timer: Timer = $Timer

var current_stars = []

func _ready() -> void:
	timer.timeout.connect(spawn_star)
	timer.wait_time = 0.5
	timer.start()


func spawn_star() -> void:
	var star = TextureRect.new()
	
	star.texture = star_assets.pick_random()

	star.custom_minimum_size = Vector2(24, 24)
	star.size = Vector2(24, 24)
	star.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	star.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED

	# Random position
	var screen_size = get_viewport_rect().size
	star.position = Vector2(
		randf_range(0, screen_size.x - 24),
		randf_range(0, screen_size.y - 24)
	)
	star.scale = Vector2(
		randf_range(0.2, 0.4),
		randf_range(0.2, 0.4)
	)

	# Start invisible
	star.modulate.a = 0

	stars.add_child(star)
	current_stars.append(star)

	# Fade in, wait, fade out
	var tween = create_tween()
	tween.tween_property(star, "modulate:a", 1.0, 0.5)
	tween.tween_interval(randf_range(0.5, 2.0))
	tween.tween_property(star, "modulate:a", 0.0, 1.0)

	tween.tween_callback(func():
		current_stars.erase(star)
		star.queue_free())
