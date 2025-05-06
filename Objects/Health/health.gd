extends StaticBody2D

@export var health = 0.5

func _on_area_2d_body_entered(body: Node2D) -> void:
	# Gain health
	if body is Player:
		body.gain_health(health)
	
	# Delete pack
	queue_free()
