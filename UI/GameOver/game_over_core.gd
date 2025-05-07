extends Control

func _input(key):
	print("Hello")
	if key is InputEventKey:
		if key.keycode == KEY_0:
			self.visible = true
			
func _on_yes_pressed() -> void:
	self.visible = false
	get_tree().reload_current_scene() # Replace with function body.


func _on_no_pressed() -> void:
	self.visible = false
	get_tree().quit() # Replace with function body.
