extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var falling = false
var jumping = false
var is_long_fall = false
var jump_max = false
var idle = false
var running = false
var turning_left = false
var turning_right = false
var rolling = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if not is_on_floor(): velocity.y += gravity * delta
	
	player_input()
	
	player_animation()
	
	move_and_slide()

func player_input():
	if not rolling:
		var direction = Input.get_axis("ui_left", "ui_right")
		velocity.x = direction * SPEED
		if is_on_floor():
			if Input.is_action_just_pressed("ui_up"): jump()

			if Input.is_action_just_pressed("ui_accept"):
				if velocity.x: roll()
				else: jump()

func jump():
	velocity.y = JUMP_VELOCITY

func roll():
	print(velocity)
	$AnimatedSprite2D.play("Roll")
	rolling = true
	await $AnimatedSprite2D.animation_finished
	rolling = false

func player_animation():
	jumping = velocity.y <= -100
	jump_max = velocity.y >- 100 and velocity.y < 0
	if not is_long_fall: is_long_fall = velocity.y > 600
	falling = velocity.y > 0
	turning_left = velocity.x < 0
	turning_right = velocity.x > 0
	running = velocity.x and not velocity.y
	idle = velocity == Vector2.ZERO and not is_long_fall and not $AnimatedSprite2D.animation == "Land"

	if turning_left:
		$AnimatedSprite2D.flip_h = true
	elif turning_right:
		$AnimatedSprite2D.flip_h = false

	if is_long_fall and velocity.y == 0:
		if turning_left or turning_right:
			roll()
		else:
			$AnimatedSprite2D.play("Land")
		is_long_fall = false

	if not rolling:
		if idle:
			$AnimatedSprite2D.play("Idle")
		elif running:
			$AnimatedSprite2D.play("Run")
		elif falling:
			$AnimatedSprite2D.play("Fall")
		elif jumping:
			$AnimatedSprite2D.play("Jump")
		elif jump_max:
			$AnimatedSprite2D.play("Jump Max")

	print($AnimatedSprite2D.animation)
