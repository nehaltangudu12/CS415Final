extends CanvasLayer

@export_file("*json") var scene_text_file: String

var in_progress: bool = false

@onready var text_label = $DialogueLabel

func _ready():
	SignalBus.connect("display_dialog", Callable(self, "on_display_dialog"))
	DialogueManager.dialogue_ended.connect(_on_dialogue_finished)

func _on_dialogue_finished(resource):
	in_progress = false
	get_tree().paused = false

func on_display_dialog(text_key: String):
	if in_progress:
		return		

	var resource_path = "res://Assets/Dialogue/" + text_key
	var resource = load(resource_path)

	if not resource:
		push_error("Failed to load dialogue resource: " + resource_path)
		return
	
	in_progress = true
	get_tree().paused = true  # ❗ prevent gameplay
	
	var balloon = await DialogueManager.show_dialogue_balloon(resource, "start")
	balloon.process_mode = Node.PROCESS_MODE_ALWAYS
	# Dialogue ends will automatically call _on_dialogue_finished()
