extends Control

@export var inv: Inv
@onready var slot1 =  $MarginContainer/HBoxContainer/Slot1
@onready var slot2 =  $MarginContainer/HBoxContainer/Slot2
@onready var slot3 =  $MarginContainer/HBoxContainer/Slot3
@onready var slot4 =  $MarginContainer/HBoxContainer/Slot4
@onready var slot5 =  $MarginContainer/HBoxContainer/Slot5

var selected = slot1

# Setting textures for inventory and selecting items
func _ready() -> void:
	slot1.texture_normal = inv.items[0].texture
	slot2.texture_normal = inv.items[1].texture
	slot3.texture_normal = inv.items[2].texture
	slot4.texture_normal = inv.items[3].texture
	slot5.texture_normal = inv.items[4].texture


func _input(event):
	if event.is_action_pressed("inventory"):
		slot1.texture_normal = inv.items[0].texture
		slot2.texture_normal = inv.items[1].texture
		slot3.texture_normal = inv.items[2].texture
		slot4.texture_normal = inv.items[3].texture
		slot5.texture_normal = inv.items[4].texture
			
func _on_slot_1_pressed() -> void:
	print("slot_1")
	print(inv.items[0].name)
	selected = slot1

func _on_slot_2_pressed() -> void:
	print("slot_2")
	selected = slot2

func _on_slot_3_pressed() -> void:
	print("slot_3")
	selected = slot3

func _on_slot_4_pressed() -> void:
	print("slot_4")
	selected = slot4

func _on_slot_5_pressed() -> void:
	print("slot_5")
	selected = slot5
