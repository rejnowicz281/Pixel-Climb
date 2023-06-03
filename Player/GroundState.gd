extends State

class_name GroundState
@export var jump_velocity: float = -400.0
@export var air_state: State
@export var rolling_state: State

func state_input(event: InputEvent):
	if event.is_action_pressed("ui_up"):
		playback.travel("Jump")
		jump()
	elif event.is_action_pressed("ui_select"):
		if character.direction:
			playback.travel("Roll")
			next_state = rolling_state
		else:
			playback.travel("Jump")
			jump()

func state_process(delta):
	if not character.is_on_floor():
		next_state = air_state

func jump():
	character.velocity.y = jump_velocity
