class_name NotifManager extends CanvasLayer

@onready var text_ballon: DialogueManagerBalloon = $DialogueBalloon
@onready var quit_indicator = $RichTextLabel

func _ready() -> void:
	quit_indicator.visible = false
	text_ballon.visible = false

func display_notif(text: String, delay_duration := 0.0):
	if text == null:
		return

	var timer = Timer.new()
	timer.wait_time = delay_duration
	timer.one_shot = true
	add_child(timer)  # Must be inside the scene tree for it to work
	timer.start()
	
	await timer.timeout  # Wait for timer to complete
	
	quit_indicator.visible = true
	text_ballon.start(text, "start")
	
	timer.queue_free()  # Clean up the timer afterwards
