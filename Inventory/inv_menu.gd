extends Control

@export var inv: Inv
@onready var player: CharacterBody2D = $"../../PlayerCat"
@onready var slot1 =  $MarginContainer/HBoxContainer/Slot1
@onready var slot2 =  $MarginContainer/HBoxContainer/Slot2
@onready var slot3 =  $MarginContainer/HBoxContainer/Slot3
@onready var slot4 =  $MarginContainer/HBoxContainer/Slot4
@onready var slot5 =  $MarginContainer/HBoxContainer/Slot5
@onready var gameLevel = $"../.."

@export var emptyObj : InvItem


var selected = slot1

# Setting textures for inventory and selecting items
func _ready() -> void:
	slot1.texture_normal = inv.items[0].texture
	slot2.texture_normal = inv.items[1].texture
	slot3.texture_normal = inv.items[2].texture
	slot4.texture_normal = inv.items[3].texture
	slot5.texture_normal = inv.items[4].texture


func _add_item(item: InvItem):
	for i in range(len(inv.items)):
		if inv.items[i].name == "empty":
			inv.items[i] = item
			break
	print("Inventory Full!")

func _input(event):
	if event.is_action_pressed("inventory"):
		slot1.texture_normal = inv.items[0].texture
		slot2.texture_normal = inv.items[1].texture
		slot3.texture_normal = inv.items[2].texture
		slot4.texture_normal = inv.items[3].texture
		slot5.texture_normal = inv.items[4].texture
			
func _on_slot_1_pressed() -> void:
	#print("slot_1")
	selected = slot1
	#label.text = inv.items[0].name
	if player.interactable != null && inv.items[0].name in player.interactable.itemNeeded:
		player.interactable.itemEvent(inv.items[0].name)
	else:
		print("can't use this item")
	gameLevel.pauseMenu()
	inv.items[0] = emptyObj

func _on_slot_2_pressed() -> void:
	#print("slot_2")
	selected = slot2
	#label.text = inv.items[1].name
	if player.interactable != null && inv.items[1].name in player.interactable.itemNeeded:
		player.interactable.itemEvent(inv.items[1].name)
	else:
		print("can't use this item")
	gameLevel.pauseMenu()
	inv.items[1] = emptyObj
func _on_slot_3_pressed() -> void:
	#print("slot_3")
	selected = slot3
	#label.text = inv.items[2].name
	if player.interactable != null && inv.items[2].name in player.interactable.itemNeeded:
		player.interactable.itemEvent(inv.items[2].name)
	else:
		print("can't use this item")
	gameLevel.pauseMenu()
	inv.items[2] = emptyObj
func _on_slot_4_pressed() -> void:
	#print("slot_4")
	selected = slot4
	#label.text = inv.items[3].name
	if player.interactable != null && inv.items[3].name in player.interactable.itemNeeded:
		player.interactable.itemEvent(inv.items[3].name)
	else:
		print("can't use this item")
	gameLevel.pauseMenu()
	inv.items[3] = emptyObj
func _on_slot_5_pressed() -> void:
	#print("slot_5")
	selected = slot5
	#label.text = inv.items[4].name
	if player.interactable != null && inv.items[4].name in player.interactable.itemNeeded:
		player.interactable.itemEvent(inv.items[4].name)
	else:
		print("can't use this item")
	gameLevel.pauseMenu()
	inv.items[4] = emptyObj
