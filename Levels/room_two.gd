extends Node2D

@export var desired_phone_number = "3142713141"

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
	# Initial Level Setup
	phone_booth.set_text_input_callback(_check_phone_number_matches)
	await get_tree().create_timer(1.0).timeout
	
	Notif.display_notif("My car is gone... did I get towed? Let me give them a call at the phone booth. Wait, what is their number?")
