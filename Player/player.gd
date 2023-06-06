extends CharacterBody2D

var speed = 300.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 0
var walk_mode: bool = false
var crouch_mode: bool = false

func _ready():
	$AnimationTree.active = true

func _physics_process(delta):
	update_movement_mode()
	if not is_on_floor(): velocity.y += gravity * delta
	
	player_input()
	
	update_facing_direction()
	
	velocity.x = direction * speed
	move_and_slide()

func update_movement_mode():
	if walk_mode:
		$UprightCollision.disabled = false
		$CrouchCollision.disabled = true
		speed = 150.0
	elif crouch_mode:
		speed = 200.0
		$UprightCollision.disabled = true
		$CrouchCollision.disabled = false
	else:
		$UprightCollision.disabled = false
		$CrouchCollision.disabled = true
		speed = 300.0
	

func player_input():
	if $CharacterStateMachine.can_move():
		direction = Input.get_axis("ui_left", "ui_right")

func update_facing_direction():
	if direction == -1:
		$Sprite2D.flip_h = true
	elif direction == 1:
		$Sprite2D.flip_h = false
