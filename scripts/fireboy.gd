extends CharacterBody2D


const SPEED = 230.0
const JUMP_VELOCITY = -300.0

@onready var body_sprite = $Body
@onready var head_sprite = $Head


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	#Get Direction: -1, 0, 1
	var direction := Input.get_axis("move_left","move_right")
	
	# Flip the Sprite (Depending of the direction of movement)
	if direction < 0:
		body_sprite.flip_h = true
		head_sprite.flip_h = true
		
	if direction > 0:
		body_sprite.flip_h = false
		head_sprite.flip_h = false
	
	# Animations
	if is_on_floor():
		if direction == 0:
			body_sprite.play("idle")
			head_sprite.play("idle")
		else:
			body_sprite.play("run")
			head_sprite.play("run")
	else:
		if velocity.y < 0:
			body_sprite.play("idle")
			head_sprite.play("jump")
		else:
			body_sprite.play("idle")
			head_sprite.play("fall")
		
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
