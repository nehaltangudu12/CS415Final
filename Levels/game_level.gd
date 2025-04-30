extends Node2D

@export var next_level:PackedScene

@onready var inv_menu = $Camera2D/InvMenu
var paused = false

func display_start_dialogue():
	Notif.display_notif("Allright, all tasks should be done. I should talk to Nathan for my check!")	

func _ready():
	# Signals
	SignalBus.open_inventory.connect(pauseMenu)
	
	# Start events
	display_start_dialogue()

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
