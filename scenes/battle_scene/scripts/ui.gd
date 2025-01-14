extends Node2D

enum ui_states {
	MAIN,
	ENEMY_SELECT,
	ACT_SELECT,
	ITEM_SELECT,
	MERCY_SELECT,
	ATTACK,
}

var current_state = ui_states.MAIN
var inactive = false

func _physics_process(delta):
	if globals.battle_data.current_battle_state == globals.battle_data.battle_states.INTRO:
		inactive = true
	elif inactive == true:
		inactive = false
