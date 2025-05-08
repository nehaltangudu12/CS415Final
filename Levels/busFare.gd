extends Sprite2D

@export var itemCount: int

var currentItemCount: int = 0

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

@onready var level_root = get_parent()
func checkItemCount():
	if currentItemCount >= itemCount:
		level_root.change_coins_found_state(level_root.COINS_FOUND_STATE.COINS_FOUND)
		Notif.display_notif("Looks like I have enough money to take the bus. Yay!")
		SceneManager.change_scene(
			"game_win",
			fade_out_options,
			fade_in_options,
			general_options,
		)
