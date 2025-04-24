extends Node

var current_level

func _ready() -> void:
	SignalBus.SWAP_LEVELS.connect(handle_level_changed)
	
	current_level = $GameLevel
	
func handle_level_changed(next_level_filepath: String):
	var s = load(next_level_filepath)
	var next_level = s.instantiate()
	add_child(next_level)
	current_level.queue_free()
	current_level = next_level
