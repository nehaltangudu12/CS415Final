extends Node2D

enum DIRECTION {LEFT, RIGHT, UP, DOWN}
@export var car_direction: DIRECTION = DIRECTION.DOWN
@export var spawn_interval: float = 2.0

@export var car_scene: PackedScene
@onready var timer: Timer = $Timer
@onready var spawn_point: Marker2D = $Marker2D

func _ready():
	timer.wait_time = spawn_interval
	timer.start()

func _on_timer_timeout() -> void:
	spawn_car()
	
func spawn_car():
	if car_scene:
		var car_instance = car_scene.instantiate()
		car_instance.global_position = spawn_point.global_position
		car_instance.car_direction = car_direction
		
		get_tree().current_scene.add_child(car_instance)
