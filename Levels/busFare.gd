extends Sprite2D

@export var itemCount: int

var currentItemCount: int = 0


@onready var level_root = get_parent()
func checkItemCount():
	if currentItemCount >= itemCount:
		level_root.change_coins_found_state(level_root.COINS_FOUND_STATE.COINS_FOUND)
		Notif.display_notif("Looks like I have enough money to take the bus. Yay!")
		GameOverCanvas.game_win()
