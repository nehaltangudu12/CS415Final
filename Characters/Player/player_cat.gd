extends CharacterBody2D

class_name Player

@export var move_speed: float = 100
@export var starting_direciton: Vector2 = Vector2(0, 1)
@export var knockback_time: float = 0.3

@onready var animation_tree = $AnimationTree

@onready var state_machine = animation_tree.get("parameters/playback")
@onready var timer = $Timer

var knockback = Vector2.ZERO
var is_knockbacked: bool = false

@export var interactable = null

func _ready() -> void:
	update_animation_parameters(starting_direciton)
		

func _physics_process(delta: float) -> void:
	# Sets timer to reset knockback
	if (knockback != Vector2.ZERO && !is_knockbacked):
		is_knockbacked = true
		timer.start(knockback_time)
		
	
	var input_direction = Vector2.ZERO
	
	# If check to prevent player from moving after being knocked backed
	if (!is_knockbacked):
		input_direction = Vector2(
			Input.get_action_strength("right") - Input.get_action_strength("left"),
			Input.get_action_strength("down") - Input.get_action_strength("up")
		)
	
	update_animation_parameters(input_direction)
	
	# Update velocity
	velocity = input_direction.normalized() * move_speed + knockback
	
	# Move and Slide function uses velocity of character body to move character on map
	move_and_slide()
	
	pick_new_state()

# Resets knockback
func _on_timer_timeout() -> void:
	knockback = Vector2.ZERO
	is_knockbacked = false

func update_animation_parameters(move_input: Vector2):
	if (move_input != Vector2.ZERO):
		animation_tree.set("parameters/Idle/blend_position", move_input)
		animation_tree.set("parameters/Walk/blend_position", move_input)

func pick_new_state():
	if (velocity != Vector2.ZERO):
		state_machine.travel("Walk", false)
	else:
		state_machine.travel("Idle", false)
