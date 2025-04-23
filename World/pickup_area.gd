extends Area2D
#@export var text_key: String = ""
@export var myItem: InvItem

@onready var interact_indicator = $CanvasLayer/RichTextLabel
@onready var pauseMenu = $"../../Camera2D/InvMenu"

var area_active: bool = false
var parent

func _ready():
	parent = get_parent()

func _input(event):
	if area_active and event.is_action_pressed("ui_accept"):
		pauseMenu._add_item(myItem)
		print("success!")
		parent.queue_free()
		
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
