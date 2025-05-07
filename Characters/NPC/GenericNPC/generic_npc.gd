class_name GenericNPC extends Node2D

@onready var dialogue_area = $DialogArea

func change_dialogue_key(new_key: String):
	dialogue_area.text_key = new_key
	
