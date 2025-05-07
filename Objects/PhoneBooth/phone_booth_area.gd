extends Area2D

@onready var interact_indicator = $CanvasLayer/RichTextLabel

@onready var user_input = $UserInput

var area_active: bool = false

func _ready():
	interact_indicator.visible = false
	user_input.connect_onsubmit(on_phonebooth_input)

func on_phonebooth_input(text: String):
	if text == "hello":
		print("DNDNDNDNDNDNDN")

func _input(event):
	if area_active and event.is_action_pressed("ui_accept"):
		user_input.input_show()
	elif area_active and Input.is_key_pressed(KEY_ESCAPE):
		user_input.input_hide()
		
func show_read():
	interact_indicator.visible = true

func exit_read():
	interact_indicator.visible = false

func _on_area_entered(area: Area2D) -> void:
	print("hello")
	area_active = true
	show_read()

func _on_area_exited(area: Area2D) -> void:
	area_active = false
	user_input.input_hide()
	exit_read()
