extends Node2D

@onready var user_input = $Area2D/UserInput

func set_text_input_callback(function: Callable):
	user_input.connect_onsubmit(function)
