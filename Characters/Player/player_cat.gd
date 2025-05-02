extends CharacterBody2D

class_name Player

@export var move_speed: float = 100
@export var starting_direciton: Vector2 = Vector2(0, 1)
@export var interactable = null

@onready var animation_tree = $AnimationTree
@onready var light = $PointLight2D
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var timer = $Timer

# Lighting parameters
var shrink_speed = 0.1  # adjust this to control speed

var knockback = Vector2.ZERO
var is_knockbacked: bool = false
var knockback_time: float = 0.3

var is_dead = false

func _ready() -> void:
	update_animation_parameters(starting_direciton)
		

func _physics_process(delta: float) -> void:
	# If dead do not run the rest of movement code
	if is_dead:
		return
	
	var input_direction = Vector2.ZERO
	
	# If check to prevent player from moving after being knocked backed
	if not is_dead and not is_knockbacked:
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
		
func _process(delta):
	# Adjust lighting around character
	if light.texture_scale > 0.0:
		light.texture_scale -= shrink_speed * delta
		if light.texture_scale < 0.0:
			GameOverCanvas.game_over()
			print("you died :(")

# Note: Damage MUST be between [0,1]
func take_damage(damage: float):
	print("You got cheese touched")
	var new_health = light.texture_scale - damage
	if new_health < 0:
			light.texture_scale = 0
			GameOverCanvas.game_over()
			is_dead = true
			print("you died :(")
	else:
		light.texture_scale = new_health

func get_knockbacked(direction: Vector2, strength: float):
	var explosion_force = direction * strength
	knockback = explosion_force
	is_knockbacked = true
	# Sets timer to reset knockback
	timer.start(knockback_time)
