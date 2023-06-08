extends State

class_name DeathState

@export var ground_state: State
@export var death_state: State

func on_enter():
	character.direction = 0
	playback.travel("Damage Group")
	damage_group_playback.travel("Take Damage")

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "Take Damage":
		if character.health > 0:
			damage_group_playback.travel("End")
			next_state = ground_state
		else:
			next_state = death_state
