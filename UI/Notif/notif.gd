class_name NotifManager extends CanvasLayer

@onready var text_ballon: DialogueManagerBalloon = $DialogueBalloon
@onready var quit_indicator = $RichTextLabel

func _ready() -> void:
	quit_indicator.visible = false
	text_ballon.visible = false

func _input(ev):
	if Input.is_key_pressed(KEY_K):
		display_notif("Hello")

func display_notif(text: String, duration := 5.0):
	if text == null:
		return

	quit_indicator.visible = true
	text_ballon.start(text, "start")
