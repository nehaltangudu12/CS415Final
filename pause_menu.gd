extends Control

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	self.visible = false
	
func pause():
	get_tree().paused = true 
	$AnimationPlayer.play("blur")

func _input(ev):
	if Input.is_key_pressed(KEY_ESCAPE):
		pause()
		self.visible = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Start with the menu hidden
	self.visible = false
	$AnimationPlayer.play("RESET") # Replace with function body.

func _on_resume_pressed() -> void:
	resume() # Replace with function body.


func _on_restart_pressed() -> void:
	resume()
	get_tree().reload_current_scene() # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().quit() # Replace with function body.
