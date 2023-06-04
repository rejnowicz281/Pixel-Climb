extends State

class_name RollingState

@export var ground_state: State

func on_enter():
	playback.travel("Roll")
	character.get_node("UprightCollision").disabled = true
	character.get_node("CrouchCollision").disabled = false
	
func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "Roll":
		next_state = ground_state

func on_exit():
	character.get_node("UprightCollision").disabled = false
	character.get_node("CrouchCollision").disabled = true
