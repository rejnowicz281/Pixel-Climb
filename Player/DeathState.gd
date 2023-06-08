extends State

class_name DamagedState

@export var ground_state: State
@export var death_state: State

func on_enter():
	damage_group_playback.travel("Death")
