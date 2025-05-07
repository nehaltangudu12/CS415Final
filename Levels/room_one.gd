extends Node2D

@export var next_level:PackedScene

@onready var inv_menu = $Camera2D/InvMenu
var paused = false

@onready var player = $PlayerCat
@onready var bartender = $Bartender
@onready var transition_area = $TransitionArea

enum DISHES_WASHED_STATE {
	DISHES_NOT_WASHED,
	DISHES_IN_PROGRESS,
	DISHES_WASHED,
}

static var dishes_washed_state: DISHES_WASHED_STATE = DISHES_WASHED_STATE.DISHES_NOT_WASHED

func _ready():
	SignalBus.open_inventory.connect(pauseMenu)
	DialogueManager.passed_title.connect(on_finished_talking_with_nathan)
	player.shrink_speed = 0.0
	var light = player.get_node("PointLight2D")
	light.energy = 0.3
	Notif.display_notif("Allright, all tasks should be done. I should talk to Nathan for my check!")	


# Catching inputs for interaction and inventory
func _input(event):
	if event.is_action_pressed("inventory"):
		pauseMenu()

func change_dishes_washed_state(state: DISHES_WASHED_STATE):
	dishes_washed_state = state
	if state == DISHES_WASHED_STATE.DISHES_WASHED:
		bartender.change_dialogue_key("bartender2.dialogue")
	
func on_finished_talking_with_nathan(title: String):
	if title == "nathan_end":
		await Notif.display_notif("Lemme get out of here, it's late... WTF, 9:00PM?", 5.0)
		transition_area.set_can_use(true)
	
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
