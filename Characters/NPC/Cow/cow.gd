extends CharacterBody2D

class_name Enemy

enum COW_STATE { IDLE, WALK, CHASE }

@export var move_speed: float = 20
@export var idle_time: float = 5
@export var walk_time: float = 2
@export var chase_time: float = 3
@export var target_to_chase: CharacterBody2D

@export var knockback_strength: float = 100.0
@export var CHASE_SPEED: float = 60.0
@export var damage: float = 0.1

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var sprite = $Sprite2D
@onready var timer = $Timer
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

var move_direction: Vector2 = Vector2.ZERO
var current_state: COW_STATE = COW_STATE.IDLE

func _ready() -> void:
	set_physics_process(false)
	call_deferred("await_for_physics")
	pick_new_state()

func await_for_physics():
	await get_tree().physics_frame
	set_physics_process(true)

func _physics_process(delta: float) -> void:
	match current_state:
		COW_STATE.WALK:
			# Update velocity
			velocity = move_direction.normalized() * move_speed
			# Move and Slide function uses velocity of character body to move character on map
			move_and_slide()
		COW_STATE.CHASE:
			navigation_agent.target_position = target_to_chase.global_position
			velocity = global_position.direction_to(navigation_agent.get_next_path_position()) * CHASE_SPEED
			move_and_slide()

# Randomly generate a move direction
# Can be either -1, 0, or 1 for x and y
func select_new_direction():
	move_direction = Vector2(
		randi_range(-1,1),
		randi_range(-1,1)
	)
	if (move_direction.x < 0):
		sprite.flip_h = true
	elif (move_direction.x > 0):
		sprite.flip_h = false

# Switch from walking to idling
func pick_new_state():
	if (current_state == COW_STATE.IDLE):
		# Change to walk state
		state_machine.travel("walk")
		current_state = COW_STATE.WALK
		select_new_direction()
		timer.start(walk_time)
	elif (current_state == COW_STATE.WALK || current_state == COW_STATE.CHASE):
		# Change to idle state
		state_machine.travel("idle")
		current_state = COW_STATE.IDLE
		timer.start(idle_time)


func _on_timer_timeout() -> void:
	pick_new_state() # Replace with function body.

# If enemy detects player, it chases player
func _on_player_detector_body_entered(body: Node2D) -> void:
	if (body is Player):
		#print("player detected")
		state_machine.travel("walk")
		current_state = COW_STATE.CHASE
		timer.start(chase_time)

func _on_hit_box_body_entered(body: Node2D) -> void:
	if body is Player:
		body.take_damage(damage)
		var direction = global_position.direction_to(body.global_position)
		body.get_knockbacked(direction, knockback_strength)
