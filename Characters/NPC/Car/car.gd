extends CharacterBody2D

@export var car_direction: DIRECTION = DIRECTION.DOWN

@onready var timer = $Timer

@onready var horizontal_sprite = $HorizontalSprite
@onready var up_sprite = $UpSprite
@onready var down_sprite = $DownSprite

@onready var horizontal_collision = $HitBox/HorizontalCollision
@onready var vertical_collision = $HitBox/VerticalCollision

@onready var horizontal_light = $HorizontalHeadLight
@onready var vertical_light = $VerticallHeadLight

enum DIRECTION {LEFT, RIGHT, UP, DOWN}

var move_direction: Vector2 = Vector2.ZERO
var move_speed: float = 150
var damage: float = 0.8
var knockback_strength: float = 500.0
var despawn_time: float = 5

func _ready() -> void:
	# Set a timer to despawn car
	timer.start(despawn_time)
	_set_direction()
	set_physics_process(true)

func _set_direction():
	match car_direction:
			DIRECTION.LEFT:
				move_direction = Vector2.LEFT
			DIRECTION.RIGHT:
				scale.x = -1
				move_direction = Vector2.RIGHT
			DIRECTION.UP:
				up_sprite.visible = true
				horizontal_sprite.visible = false
				scale.y = -1
				vertical_collision.disabled = false
				horizontal_collision.disabled = true
				vertical_light.visible = true
				horizontal_light.visible = false
				move_direction = Vector2.UP
			DIRECTION.DOWN:
				down_sprite.visible = true
				horizontal_sprite.visible = false
				vertical_collision.disabled = false
				horizontal_collision.disabled = true
				vertical_light.visible = true
				horizontal_light.visible = false
				move_direction = Vector2.DOWN

func _physics_process(delta: float) -> void:
		# Update velocity
		velocity = move_direction.normalized() * move_speed
		# Move and Slide function uses velocity of character body to move character on map
		move_and_slide()

func _on_hit_box_body_entered(body: Node2D) -> void:
	if body is Player:
		body.take_damage(damage, "car")
		var direction = global_position.direction_to(body.global_position)
		body.get_knockbacked(direction, knockback_strength)


func _on_timer_timeout() -> void:
	queue_free()
