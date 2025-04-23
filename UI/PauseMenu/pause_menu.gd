extends Control

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	self.visible = false	

func pause():
	get_tree().paused = true 
	$AnimationPlayer.play("blur")

func _input(key):
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
