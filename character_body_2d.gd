extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -700.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D.animation = "jump"

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = direction<0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y ==0:
			$AnimatedSprite2D.animation = "stand"
	move_and_slide()
	$AnimatedSprite2D.play()
