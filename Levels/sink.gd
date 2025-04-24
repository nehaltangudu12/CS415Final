extends Sprite2D

@export var itemCount: int

var currentItemCount: int = 0

func checkItemCount():
	if currentItemCount >= itemCount:
		print("You washed all the dishes!")
