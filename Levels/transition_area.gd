extends Area2D

@export var text_key: String = ""
@export var can_use: bool = false

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

@onready var interact_indicator = $CanvasLayer/RichTextLabel

var area_active: bool = false

func _input(event):
	if can_use and area_active and event.is_action_pressed("ui_accept"):
		SceneManager.change_scene(
			text_key,
			fade_out_options,
			fade_in_options,
			general_options,
		)
		
func set_can_use(new_state: bool):
	can_use = new_state		
		
func show_read():
	interact_indicator.visible = true

func exit_read():
	interact_indicator.visible = false
		
func _on_DialogArea_area_entered(_area):
	if can_use:
		area_active = true
		show_read()
	
func _on_DialogArea_area_exited(_area):
	if can_use:
		area_active = false
		exit_read()
