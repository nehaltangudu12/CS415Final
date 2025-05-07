extends CanvasLayer

@onready var game_over_screen = $GameOverCore
func _ready() -> void:
	game_over_screen.visible = false

func game_over():
	game_over_screen.visible = true
