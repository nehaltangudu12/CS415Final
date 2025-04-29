extends Sprite2D

@export var itemCount: int

var currentItemCount: int = 0

@onready var level_root = get_parent()
func checkItemCount():
	if currentItemCount >= itemCount:
		level_root.change_dishes_washed_state(level_root.DISHES_WASHED_STATE.DISHES_WASHED)
		Notif.display_notif("Seems to be all the dishes. I can't believe Nathan made me stay late for this...")
