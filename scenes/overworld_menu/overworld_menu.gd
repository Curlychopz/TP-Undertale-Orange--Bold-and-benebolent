extends Node2D

enum states {
	QUIT,
	MENU
}
var current_state = states.MENU

@onready var global = get_node("/root/Globals") 
@onready var buttons = [$section_main/item, $section_main/equip, $section_main/stats, $section_main/cell]
@onready var soul = $Soul
@onready var select_fx = $section_main/select_fx

var index = 0
var selected_button = null

var quit_timer = 0.3

func _ready():
	$section_main/bg.scale = Vector2.ZERO
	for i in range(buttons.size()):
		buttons[i].position.y += 40 + 40 * i
		buttons[i].position.x += 40 + 40 * i
	select_fx.position.x += 1000000

func _physics_process(delta):
	if current_state == states.QUIT:
		$section_main/bg.scale /= 1.2
		for i in range(buttons.size()):
			buttons[i].position.x += -15 + -15 * i
		
		soul.position.y -= 20
		select_fx.scale /= 2
		
		quit_timer -= delta
		if quit_timer < 0:
			queue_free()
			
	elif current_state == states.MENU:
		$section_main/bg.scale += (Vector2.ONE - $section_main/bg.scale) * 0.2
		
		for i in range(buttons.size()):
			buttons[i].modulate = Color.WHITE
			buttons[i].position += ($section_main/anchor.position + Vector2(0, i * 20) - buttons[i].position) * 0.2
		
		
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
			
		if Input.is_action_just_pressed("cancel") or Input.is_action_just_pressed("inv"):
			global.tyson_input = true
			current_state = states.QUIT

		
		selected_button = buttons[index]
		selected_button.modulate = Color.BLACK
		selected_button.position.x += 2
		
		soul.position += (selected_button.position + Vector2(12,-10) - soul.position) * 0.4
		select_fx.position += (selected_button.position + Vector2(25, -22) - select_fx.position) * 0.4
	
	
