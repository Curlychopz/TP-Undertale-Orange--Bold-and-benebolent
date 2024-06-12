extends Node2D

var index = 0
var current_selection = self

@onready var buttons = [$fight, $act, $focus, $item, $mercy]
@onready var rect_size = $fight/rect.size

func _ready():
	form_ui_intro_formation()
	get_window().mode = Window.MODE_FULLSCREEN
	

func _physics_process(delta):
	
	position /= 1.3
	modulate += (Color.WHITE - modulate) * 0.2
	
	if get_parent().current_state == get_parent().ui_states.MAIN:
		current_selection = buttons[index]
		get_parent().get_parent().soul_selection.position += (current_selection.position - Vector2(23,3) - get_parent().get_parent().soul_selection.position) * 0.2
		
		# controls
		if Input.is_action_just_pressed("right"):
			if index < buttons.size() - 1:
				index += 1
			else:
				index = 0
			$menu_move.playing = true
		if Input.is_action_just_pressed("left"):
			if index > 0:
				index -= 1
			else:
				index = buttons.size() - 1
			$menu_move.playing = true
		
			
		if Input.is_action_just_pressed("accept"):
			button_press_anim()
			if current_selection == $fight:
				get_parent().current_state = get_parent().ui_states.ENEMY_SELECT
			
			
				
	ui_animations(delta)
	

func ui_animations(delta):

	# -- animation --
	for i in range(buttons.size()):
		var target_pos = (($anchor.position + Vector2(60 * i, 0)) - Vector2(25 * buttons.size(), 0))
		buttons[i].position += (target_pos  - buttons[i].position) * 0.2
		if buttons[i].position.distance_squared_to(target_pos) < 3:
			buttons[i].get_node("text").scale += (Vector2(0.3,0.3) - buttons[i].get_node("text").scale) * 0.2
			buttons[i].get_node("rect/ColorRect").position += Vector2(32, -32) / ((i + 2) * 1)
			buttons[i].modulate = Color.ORANGE
			buttons[i].get_node("rect").size += (rect_size - buttons[i].get_node("rect").size) * 0.2
			buttons[i].get_node("rect").scale += (Vector2.ONE - buttons[i].get_node("rect").scale) * 0.2
			buttons[i].scale += (Vector2.ONE - buttons[i].scale) * 0.2
		else:
			buttons[i].modulate = Color8(255,255,0,  int(abs(sin(Time.get_ticks_msec() * delta * 3) * 255)))
			
	current_selection.scale += Vector2.ONE * delta / 3
	
	current_selection.modulate = Color.CYAN
		

func button_press_anim():
	
	current_selection.scale = Vector2(0.5, 2)
	current_selection.get_node("rect/ColorRect").position = Vector2(-84.72, 64)
			
func form_ui_intro_formation():
	for i in range(buttons.size()):
		buttons[i].position.y = 100000 + 100000 * i
		buttons[i].position.x = -100000 + -100000 * i
		
		buttons[i].get_node("text").scale /= 5
		buttons[i].get_node("rect").size = Vector2.ONE
