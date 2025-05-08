extends CharacterBody2D

@export var move_speed: float = 20
@export var target_to_chase: CharacterBody2D
@export var knockback_strength: float = 0.0
@export var damage: float = 1.0

@onready var sprite = $Sprite2D
@onready var timer = $Timer
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

var move_direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	assert (target_to_chase, "Stalker Error: Be sure to set target_to_chase to player.")
	set_physics_process(true)

func _physics_process(delta: float) -> void:
	navigation_agent.target_position = target_to_chase.global_position
	velocity = global_position.direction_to(navigation_agent.get_next_path_position()) * move_speed
	move_and_slide()

func _on_hit_box_body_entered(body: Node2D) -> void:
	if body is Player:
		body.take_damage(damage)
		var direction = global_position.direction_to(body.global_position)
		body.get_knockbacked(direction, knockback_strength)
