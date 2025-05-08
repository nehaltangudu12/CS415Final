extends Node2D

@export var next_level:PackedScene

@onready var inv_menu = $Camera2D/InvMenu
var paused = false

@onready var player = $PlayerCat
#@onready var transition_area = $TransitionArea

enum COINS_FOUND_STATE {
	COINS_NOT_FOUND,
	COINS_IN_PROGRESS,
	COINS_FOUND,
}

static var coins_found_state: COINS_FOUND_STATE = COINS_FOUND_STATE.COINS_NOT_FOUND


func change_coins_found_state(state: COINS_FOUND_STATE):
	coins_found_state = state
	if state == COINS_FOUND_STATE.COINS_FOUND:
		print("found all coins")
		#REPLACE DIALOGUE TRIGGER HERE -> bartender.change_dialogue_key("bartender2.dialogue")

func _ready():
	SignalBus.set_current_level("Room_Four")
	SignalBus.open_inventory.connect(pauseMenu)
	player.shrink_speed = 0.01
	var light = player.get_node("PointLight2D")
	light.energy = 0.5
	Notif.display_notif("There's a bus! But damn I don't have any coins. Gotta collect 5 coins to pay the bus fare!")	


# Catching inputs for interaction and inventory
func _input(event):
	if event.is_action_pressed("inventory"):
		pauseMenu()
	
# Pause Logic
func pauseMenu():
	if paused:
		inv_menu.hide()
		Engine.time_scale = 1
	else:
		inv_menu.show()
		Engine.time_scale = 0
	
	paused = !paused

func _on_button_pressed() -> void:
	SignalBus.SWAP_LEVELS.emit(next_level.get_path())
