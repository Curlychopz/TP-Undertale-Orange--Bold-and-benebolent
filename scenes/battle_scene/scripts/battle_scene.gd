extends CanvasLayer
class_name battle

var enemy_scenes = [
	preload("res://scenes/battle_enemy/test_enemy.tscn"),
	preload("res://scenes/battle_enemy/test_enemy.tscn"),
	preload("res://scenes/battle_enemy/test_enemy.tscn"),
	
	
]
var enemy = []
var battle_bg = preload("res://scenes/battle_scene/resources/backgrounds/background_generic.tscn")

@onready var soul_selection = $soul_selection

enum battle_states {
	PLAYER_TURN,
	PLAYER_ATTACK,
	ENEMY_DIALOUGE,
	ENEMY_ATTACK,
	WIN_BATTLE
}

var current_battle_state = battle_states.PLAYER_TURN
var box_anchor = Vector2.ZERO
var box_pos = Vector2.ZERO

func _ready():
	$bg.add_child(battle_bg.instantiate())
	for i in enemy_scenes:
		var enemy_inst = i.instantiate()
		$enemy.add_child(enemy_inst)
		enemy.append(enemy_inst)
		

func _physics_process(delta):
	
	Globals.battle_data = self
	structure_enemy(delta)
	
func structure_enemy(delta):
	for i in range(enemy.size()):
		enemy[i].position.x = (160 + (i * 55)) - (i + 55)
		enemy[i].global_position.y = $box/boxrect.global_position.y + -22 + $box/boxrect/up.position.y * 2
		
	
	
