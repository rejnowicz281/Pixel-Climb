extends CharacterBody2D


const SPEED = 300.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 0

func _ready():
	$AnimationTree.active = true

func _physics_process(delta):
	if not is_on_floor(): velocity.y += gravity * delta
	
	player_input()
	
	update_facing_direction()
	update_animation_paramaters()

	move_and_slide()

func player_input():
	if $CharacterStateMachine.can_move():
		direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * SPEED

func update_facing_direction():
	if direction == -1:
		$Sprite2D.flip_h = true
	elif direction == 1:
		$Sprite2D.flip_h = false

func update_animation_paramaters():
	$AnimationTree.set("parameters/Move/blend_position", direction)
