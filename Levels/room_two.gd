extends Node2D

@export var next_level:PackedScene
@export var desired_phone_number = "3142713141"

@onready var inv_menu = $Camera2D/InvMenu
var paused = false

@onready var player = $PlayerCat
@onready var transition_area = $TransitionArea

@onready var phone_booth = $PhoneBooth

func _check_phone_number_matches(val: String):
	if val == desired_phone_number:
		Notif.display_notif("Ring... Ring... Ring...")
		await get_tree().create_timer(3).timeout
		Notif.display_notif("They're not recieving. Looks like I'll have to take the bus home today")
		transition_area.set_can_use(true)
	else:
		Notif.display_notif("Must be the wrong number...")
		
func _ready():
	SignalBus.set_current_level("Room_Two")
	SignalBus.open_inventory.connect(pauseMenu)
	player.shrink_speed = 0.01
	var light = player.get_node("PointLight2D")
	phone_booth.set_text_input_callback(_check_phone_number_matches)
	
	# Intro text
	await get_tree().create_timer(1.0).timeout
	Notif.display_notif("My car is gone... did I get towed? Let me give them a call at the phone booth. Wait, what is their number?")

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
