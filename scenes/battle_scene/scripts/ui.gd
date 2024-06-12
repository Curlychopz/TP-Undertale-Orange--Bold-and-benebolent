extends Node2D

enum ui_states {
	MAIN,
	ENEMY_SELECT,
	ACT_SELECT,
	ITEM_SELECT,
	MERCY_SELECT,
	ATTACK,
	INACTIVE
}

var current_state = ui_states.MAIN
