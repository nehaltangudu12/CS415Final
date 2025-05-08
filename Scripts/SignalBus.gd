extends Node

signal display_dialog(text_key)
signal open_inventory
signal SWAP_LEVELS(next_level_filepath)
signal SET_CURRENT_LEVEL(set_current_level_key)

var current_level_key: String = "Title"

func set_current_level(new_key: String):
	current_level_key = new_key
	emit_signal("SET_CURRENT_LEVEL", new_key)
