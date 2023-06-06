extends State

class_name AirState

@export var hard_landing_state: State
@export var soft_landing_state: State
@export var rolling_state: State
@export var double_jump_velocity: float = -400.0
@export var long_fall_height: float = 600

var is_long_fall = false
var has_double_jumped = false

func state_process(delta):
	if character.is_on_floor():
		if Input.is_action_pressed("ui_accept") and character.direction:
			next_state = rolling_state
		elif is_long_fall:
			next_state = hard_landing_state
		elif not is_long_fall:
			next_state = soft_landing_state
		is_long_fall = false
		has_double_jumped = false
	elif character.velocity.y > long_fall_height:
		is_long_fall = true
	elif not has_double_jumped:
		if character.velocity.y > 0:
			playback.travel("Fall")
		elif character.velocity.y >= -100:
			playback.travel("Jump Max")

func state_input(event: InputEvent):
	if event.is_action_pressed("ui_up") and not has_double_jumped:
		double_jump()

func double_jump():
	character.velocity.y = double_jump_velocity
	playback.travel("Air Spin")
	has_double_jumped = true
