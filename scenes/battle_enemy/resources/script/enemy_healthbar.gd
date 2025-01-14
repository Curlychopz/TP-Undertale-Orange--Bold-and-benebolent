extends Node2D

var show = true
var process_delay = 100


func _physics_process(delta):
	if globals.battle_data.current_battle_state != globals.battle_data.battle_states.INTRO:
		process_delay -= delta
		if show and process_delay < 0:
			
			visible = true
			$healthbar.max_value = get_parent().max_health
			$healthbar.value += (get_parent().health - $healthbar.value) * 0.04
			if round($healthbar.value) == round(get_parent().health):
				show = false
		else:
			visible = false
			
