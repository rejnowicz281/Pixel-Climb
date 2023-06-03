extends State

class_name SoftLandingState

@export var ground_state: State

func state_process(delta):
	if character.direction:
		next_state = ground_state
		playback.travel("Move")

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "Land":
		next_state = ground_state
		playback.travel("Move")
