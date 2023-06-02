extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var falling = false
var jumping = false
var is_long_fall = false
var jump_max = false
var idle = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	print(velocity)
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * SPEED
	
	player_animation()
	
	move_and_slide()

func player_animation():
	jumping = velocity.y <= -100
	jump_max = velocity.y >- 100 and velocity.y < 0
	if not is_long_fall: is_long_fall = velocity.y > 600
	falling = velocity.y > 0

	if falling:
		$AnimatedSprite2D.play("Fall")
		print("Falling")
	elif jumping:
		$AnimatedSprite2D.play("Jump")
		print("Jump")
	elif jump_max:
		$AnimatedSprite2D.play("Jump Max")
		print("Max Jump")
	elif is_long_fall and velocity.y == 0:
		$AnimatedSprite2D.play("Land")
		print("Big Landing")
		await $AnimatedSprite2D.animation_finished
		is_long_fall = false
	else:
		print("Idle")
		$AnimatedSprite2D.play("Idle")
