extends Node2D

@export var next_level:PackedScene

@onready var inv_menu = $Camera2D/InvMenu
var paused = false

@onready var player = $PlayerCat
@onready var transition_area = $TransitionArea

func _ready():
	SignalBus.set_current_level("Room_Three")
	SignalBus.open_inventory.connect(pauseMenu)
	player.shrink_speed = 0.08
	var light = player.get_node("PointLight2D")
	transition_area.set_can_use(true)

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
