extends State

class_name HardLandingState

@export var ground_state: State

func on_enter():
	character.direction = 0
	
func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "Land":
		next_state = ground_state
