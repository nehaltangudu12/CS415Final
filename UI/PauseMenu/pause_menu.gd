extends Control

func resume():
	$AnimationPlayer.play_backwards("blur")
	self.visible = false	

func pause():
	$AnimationPlayer.play("blur")

func _input(key):
	print("Hello")
	if key is InputEventKey:
		if key.keycode == KEY_ESCAPE:
			self.visible = true
			pause()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("RESET") # Replace with function body.
	self.visible = false


func _on_resume_pressed() -> void:
	resume() # Replace with function body.


func _on_restart_pressed() -> void:
	resume()
	get_tree().reload_current_scene() # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().quit() # Replace with function body.
