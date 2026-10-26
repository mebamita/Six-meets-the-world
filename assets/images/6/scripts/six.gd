extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -500.0
const DEATH_Y = 1000.0

var start_position: Vector2

func _ready() -> void:
	start_position = global_position

func _physics_process(delta: float) -> void:
	if global_position.y > DEATH_Y:
		global_position = start_position
		velocity = Vector2.ZERO

	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
