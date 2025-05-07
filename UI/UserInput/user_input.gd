extends Node2D

@export var max_len = 10
@onready var line_edit: LineEdit = $CanvasLayer/LineEdit

func input_show():
	self.visible = true
	line_edit.visible = true

func input_hide():
	self.visible = false
	line_edit.visible = false

func get_text():
	return line_edit.text

func connect_onsubmit(on_submit_func: Callable):
	line_edit.text_submitted.connect(on_submit_func)

func _ready():
	line_edit.max_length = max_len
	input_hide()
