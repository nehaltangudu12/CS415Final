extends Node2D

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
	
var current_level_key = "Title"

func _ready() -> void:
	SignalBus.SET_CURRENT_LEVEL.connect(set_current_level_key)
	set_current_level_key(SignalBus.current_level_key)
	
func set_current_level_key(new_current_level_key):
	current_level_key = new_current_level_key

func _on_restart_button_down() -> void:
	SceneManager.change_scene(
		current_level_key,
		fade_in_options,
		fade_out_options,
		general_options,
	)

func _on_quit_button_down() -> void:
	get_tree().quit() # Replace with function body.
