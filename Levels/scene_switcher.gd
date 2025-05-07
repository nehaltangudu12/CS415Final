extends Node

var current_level

@export var fade_out_speed: float = 1.0
@export var fade_in_speed: float = 1.0
@export var fade_out_pattern: String = "fade"
@export var fade_in_pattern: String = "fade"
@export var fade_out_smoothness = 0.1 # (float, 0, 1)
@export var fade_in_smoothness = 0.1 # (float, 0, 1)
@export var fade_out_inverted: bool = false
@export var fade_in_inverted: bool = false
@export var color: Color = Color(0, 0, 0)
@export var timeout: float = 0.0
@export var clickable: bool = false
@export var add_to_back: bool = true

@onready var fade_out_options = SceneManager.create_options(fade_out_speed, fade_out_pattern, fade_out_smoothness, fade_out_inverted)
@onready var fade_in_options = SceneManager.create_options(fade_in_speed, fade_in_pattern, fade_in_smoothness, fade_in_inverted)
@onready var general_options = SceneManager.create_general_options(color, timeout, clickable, add_to_back)

func _ready() -> void:
	SignalBus.SWAP_LEVELS.connect(handle_level_changed)
	current_level = $RoomOne
	
	# Start at the main menu
	SceneManager.change_scene(
		"Room_One",
		fade_in_options,
		fade_out_options,
		general_options,
	)
	
func handle_level_changed(next_level_filepath: String):
	var s = load(next_level_filepath)
	var next_level = s.instantiate()
	add_child(next_level)
	current_level.queue_free()
	current_level = next_level
