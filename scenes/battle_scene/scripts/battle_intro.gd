extends CanvasLayer

func _ready():
	pass
	
func initiate_transition_to_battle():
	get_parent().show_bg = true

func _on_animation_player_animation_finished(anim_name):
	get_parent().current_battle_state = get_parent().battle_states.PLAYER_TURN
	queue_free()
