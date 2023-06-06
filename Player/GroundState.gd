extends State

class_name GroundState
@export var jump_velocity: float = -400.0
@export var air_state: State
@export var rolling_state: State

func on_enter():
	playback.travel("Move Group")

func state_input(event: InputEvent):
	if event.is_action_pressed("hit_yourself"):
		character.health -= 1
		move_group_playback.travel("End")
		playback.travel("Take Damage")
	elif event.is_action_pressed("ui_up"):
		move_group_playback.travel("End")
		playback.travel("Jump")
		jump()
	elif event.is_action_pressed("ui_select"):
		if character.direction:
			move_group_playback.travel("End")
			playback.travel("Roll")
			next_state = rolling_state
		else:
			move_group_playback.travel("End")
			playback.travel("Jump")
			jump()
	elif event.is_action_pressed("walk_mode"):
		character.walk_mode = not character.walk_mode
		character.crouch_mode = false
	elif event.is_action_pressed("crouch_mode"):
		character.crouch_mode = not character.crouch_mode
		character.walk_mode = false

func state_process(delta):
	if not character.is_on_floor():
		next_state = air_state
	elif character.health <= 0:
		move_group_playback.travel("End")
		playback.travel("Death")
	elif character.direction:
		if character.walk_mode:
			move_group_playback.travel("Walk")
		elif character.crouch_mode:
			move_group_playback.travel("Crouch Walk")
		else:
			move_group_playback.travel("Run")
	else:
		if character.crouch_mode:
			move_group_playback.travel("Crouch Idle")
		else:
			move_group_playback.travel("Idle")

func on_exit():
	character.walk_mode = false
	character.crouch_mode = false
	
func jump():
	character.velocity.y = jump_velocity
