extends Area2D

@export var text_key: String = ""

@onready var interact_indicator = $CanvasLayer/RichTextLabel

var area_active: bool = false

func _input(event):
	if area_active and event.is_action_pressed("ui_accept"):
		SignalBus.emit_signal("display_dialog", text_key)
		
func show_read():
	interact_indicator.visible = true

func exit_read():
	interact_indicator.visible = false
		
func _on_DialogArea_area_entered(_area):
	area_active = true
	show_read()
	
func _on_DialogArea_area_exited(_area):
	area_active = false
	exit_read()
