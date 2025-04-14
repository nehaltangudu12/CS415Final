extends Node2D

@onready var pause_menu = $Camera2D/PauseMenu
var paused = false

# Catching inputs for interaction and inventory
func _input(event):
	if event.is_action_pressed("interact"):
		print("Interacting!")
	if event.is_action_pressed("inventory"):
		pauseMenu()

# Pause Logic
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	
	paused = !paused
