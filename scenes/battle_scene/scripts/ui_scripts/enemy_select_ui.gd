extends Node2D

@onready var button_inst = $enemy_select_btn.duplicate()

var buttons = []
var index = 0
var selected_enemy = null
var selected_button = self

var just_entered_state = false

func setup_buttons():
	for i in buttons:
		i.queue_free()
	buttons = []
		
	for i in range(Globals.battle_data.enemy.size()):
		var btn_inst = button_inst.duplicate()
		#button_inst.global_position = Globals.battle_data.box_pos
		#button_inst.position.y = 0
		#button_inst.position.y = i * 16
		#button_inst.position.x += -7 + -7 * i
		$container.add_child(btn_inst)
		buttons.append(btn_inst)
		
func _ready():
	$enemy_select_btn.queue_free()
	

func _physics_process(delta):
	
	position /= 1.3
	if get_parent().current_state == get_parent().ui_states.ENEMY_SELECT:
		modulate += (Color.WHITE - modulate) * 0.5
		animations(delta)
		
		if just_entered_state == false:
			setup_buttons()
			just_entered_state = true
		selected_button = buttons[index]
		
			
		if Input.is_action_just_pressed("down"):
			if index < buttons.size() - 1:
				index += 1
			else:
				index = 0
				
		if Input.is_action_just_pressed("up"):
			if index > 0:
				index -= 1
			else:
				index = buttons.size() - 1
			
		if Input.is_action_just_pressed("cancel"):
			get_parent().current_state = get_parent().ui_states.MAIN
			
			
	else:
		position.y += 4
		modulate += (Color.TRANSPARENT - modulate) * 0.5
		just_entered_state = false
		
		
func animations(delta):
	for i in range(buttons.size()):
		buttons[i].position += (Vector2(0,i * 16) - buttons[i].position) * 0.2
	
	Globals.battle_data.soul_selection.position += (selected_button.global_position - Globals.battle_data.soul_selection.position) * 0.2
	$container.position = Globals.battle_data.box_anchor + Vector2(10,16)
	Globals.battle_data.get_node("ui/player_turn_ui").position.y += 2
	Globals.battle_data.get_node("ui/player_turn_ui").modulate -= Color.WHITE * delta * 6
	
	selected_button.position.x += 1
	
