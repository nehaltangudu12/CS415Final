extends Area2D
#@export var text_key: String = ""
@export var itemNeeded: Array = ["Plate","Cup","Bowl"]

@onready var interact_indicator = $CanvasLayer/RichTextLabel
@onready var player = $"../../PlayerCat"

var area_active: bool = false


func itemEvent(item):
	get_parent().currentItemCount += 1
	get_parent().checkItemCount()
	print("used correct item!")
	
func _input(event):
	if area_active and event.is_action_pressed("ui_accept"):
		SignalBus.emit_signal("open_inventory")
		
func show_read():
	interact_indicator.visible = true

func exit_read():
	interact_indicator.visible = false
		
func _on_DialogArea_area_entered(_area):
	area_active = true
	player.interactable = self
	show_read()
	
func _on_DialogArea_area_exited(_area):
	area_active = false
	player.interactable = null
	exit_read()
