extends CanvasLayer
class_name battle

var show_bg = false


var enemy_scenes = [
	preload("res://scenes/battle_enemy/test_enemy.tscn"),
	preload("res://scenes/battle_enemy/test_enemy.tscn"),
	preload("res://scenes/battle_enemy/test_enemy.tscn"),
	
	
]
var enemy = []
var battle_bg = preload("res://scenes/battle_scene/resources/backgrounds/background_generic.tscn")

@onready var soul_selection = $soul_selection

enum battle_states {
	INTRO,
	PLAYER_TURN,
	PLAYER_ATTACK,
	ENEMY_DIALOUGE,
	ENEMY_ATTACK,
	WIN_BATTLE
}

var current_battle_state = battle_states.INTRO
var box_anchor = Vector2.ZERO
var box_pos = Vector2.ZERO

var intro = preload("res://scenes/battle_scene/battle_intro.tscn")

func _ready():
	$bg.add_child(battle_bg.instantiate())
	for i in range(enemy_scenes.size()):
		var enemy_inst = enemy_scenes[i].instantiate()
		$enemy.add_child(enemy_inst)
		enemy_inst.position = Vector2(-430,430) * (i + 1)
		enemy_inst.id = (i + 1)
		enemy.append(enemy_inst)
		
	add_child(intro.instantiate())
	
func _physics_process(delta):
	
	globals.battle_data = self
	
	misc_process()

	
	if current_battle_state == battle_states.INTRO:
		process_intro(delta)
	else:
		structure_enemy(delta)
	
func misc_process():
	
	# :: Shake ::
	offset = Vector2(randf_range(-globals.shake,globals.shake),randf_range(-globals.shake,globals.shake))
	
	if show_bg:
		$bg.show()
	else:
		$bg.hide()
	
func structure_enemy(delta):
	for i in range(enemy.size()):
		enemy[i].position.x += ((160 + (i * 55)) - (i + 55) - enemy[i].position.x) * 0.1
		enemy[i].global_position.y += ($box/boxrect.global_position.y + -22 + $box/boxrect/up.position.y * 2 - enemy[i].global_position.y) * 0.1
		
func init_attack(enemy_index):
	current_battle_state = battle_states.PLAYER_ATTACK
	$ui.current_state = $ui.ui_states.ATTACK
	$ui/attack_ui.enemy_to_attack = enemy[enemy_index]

func init_box():
	pass

func process_intro(delta):
	pass
