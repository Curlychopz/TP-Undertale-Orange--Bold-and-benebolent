extends Node2D

@onready var pos = $boxrect.position

var size_x = 130
var size_y = 33

func _ready():
	$boxrect.position.y += -200

func _physics_process(delta):
	Globals.battle_data.box_pos = $boxrect.position
	Globals.battle_data.box_anchor = $boxrect/bg.global_position
	
	if Globals.battle_data.current_battle_state != Globals.battle_data.battle_states.INTRO:
		
		$boxrect/right.position.x += (size_x - 1 - $boxrect/right.position.x) * 0.2
		$boxrect/right.scale.y += (size_y  - $boxrect/right.scale.y) * 0.2
		
		$boxrect/up.position.y += (-size_y + 1 - $boxrect/up.position.y) * 0.2
		$boxrect/up.scale.x += (-size_x  - $boxrect/up.scale.x) * 0.2
		
		$boxrect/left.position.x += (-size_x + 1 - $boxrect/left.position.x) * 0.2
		$boxrect/left.scale.y += (-size_y - $boxrect/left.scale.y) * 0.2
		
		$boxrect/down.position.y += (size_y - 1 - $boxrect/down.position.y) * 0.2
		$boxrect/down.scale.x += (size_x  - $boxrect/down.scale.x) * 0.2

		$boxrect/bg.position = Vector2($boxrect/up.scale.x, $boxrect/left.scale.y)
		$boxrect/bg.scale += ( Vector2(size_x, size_y) - $boxrect/bg.scale) * 0.2
		
		$boxrect.position += (pos - $boxrect.position) * 0.2
	
	
	#if Input.is_action_just_pressed("accept"):
		#
		#size_x = randi_range(6,150)
		#size_y = randi_range(6,100)
	
	
