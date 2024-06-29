extends Node2D

@onready var attack_bar = $line
@onready var reticle = $reticle

var crit_pos = Vector2.ZERO
var enemy_to_attack = self

var just_entered = false

var delay = 0.06
var bar_speed = 3.2
var bar_miss = false

var initiated_attack = false
var attacked = false

var attack_land_timer = 1
var attack_finish_timer = 1

func _physics_process(delta):
	if get_parent().current_state == get_parent().ui_states.ATTACK and not get_parent().inactive:
		
		Globals.battle_data.get_node("ui/player_turn_ui").position.y += 4
		Globals.battle_data.get_node("ui/player_turn_ui").modulate -= Color.WHITE * delta * 6
		
		scale = scale.lerp(Vector2.ONE, delta * 10)
		modulate = modulate.lerp(Color.WHITE,delta * 10)
		
		get_parent().get_parent().get_node("soul_selection").position += (Vector2(23,200) - get_parent().get_parent().get_node("soul_selection").position) * 0.4
		
		if not initiated_attack:
			attack_bar.position.x += bar_speed
		else:
			attack_land_timer -= delta
			if attack_land_timer < 0:
				if not attacked:
					attack()
					attacked = true
				
			if attacked:
				attack_finish_timer -= delta
				if attack_finish_timer < 0:
					finish_attack()
	
		if just_entered == false:
			reset()
			just_entered = true
		
		if attack_bar.position.x > $treshold.position.x:
			miss()
			
		if Input.is_action_just_pressed("accept") and attack_bar.position.x > 25:
			initiated_attack = true
		
	else:
		reset()
		scale = scale.lerp(Vector2(1,0.3), delta * 10)
		just_entered = false
		modulate = modulate.lerp(Color.TRANSPARENT,delta * 10)

func miss():
	bar_miss = true
	get_parent().current_state = get_parent().ui_states.MAIN

func finish_attack():
	Globals.battle_data.current_battle_state = Globals.battle_data.battle_states.ENEMY_ATTACK
	Globals.battle_data.get_node("ui").current_state = Globals.battle_data.get_node("ui").ui_states.MAIN

func reset():
	attack_finish_timer = 1
	attack_land_timer = 1
	attacked = false
	initiated_attack = false
	attack_bar.position.x = 20

func attack():
	enemy_to_attack.damage(25)
	
