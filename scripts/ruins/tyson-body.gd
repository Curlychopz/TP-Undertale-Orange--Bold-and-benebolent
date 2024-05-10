extends CharacterBody2D



var tyson_anim = "down"
var tyson_speed = 1.3
var test_toggle = 0
#var tyson_input = true  
var cutsNum = 0
var transition = false

signal Coral1
signal in_trans_1
signal RuinsMusic

@export var tele_pos: Vector2
@onready var global = get_node("/root/Globals") 
@onready var timerNOTUSE = $tyson_timer
@onready var cut_timer = $cutscene_timer
@onready var scene_sw_ruins = $".."
@onready var View = $TysonView
@onready var trans = $"../Transition"

func wait_for_timer(time_s):
	cut_timer.set_wait_time(time_s)
	cut_timer.start()
	await cut_timer.timeout

func cutsceneInit(): #gets tyson and the globals ready for cutscenes
	global.tyson_input = false
	global.global_flag = global.global_flag + 1
	global.in_cutscene = true
	
func trans_representation(room):
	if Input.is_action_pressed("up") and global.tyson_input == true:
		($"tyson-sprite" as AnimatedSprite2D).stop()
		global.tyson_input = false
		transition = true
		trans.play("transition in")
		var timer : Timer = Timer.new()
		add_child(timer)
		timer.one_shot = true
		timer.autostart = false
		timer.wait_time = 0.5
		timer.timeout.connect(func(): 
			global_position = scene_sw_ruins.room.global_position
			#look i was going to do this cool array but honestly i cba
			View.limit_top = scene_sw_ruins.room.cam_pos[0]
			View.limit_right = scene_sw_ruins.room.cam_pos[1]
			View.limit_bottom = scene_sw_ruins.room.cam_pos[2]
			View.limit_left = scene_sw_ruins.room.cam_pos[3]
			trans.play("transition out")
			global.tyson_input = true
			var timer2 : Timer = Timer.new()
			add_child(timer2)
			timer2.one_shot = true
			timer2.autostart = false
			timer2.wait_time = 0.5
			timer2.timeout.connect(func(): 
				transition = false
				global.tyson_input = true
			)
			timer2.start()
				
			
		)
		timer.start()
	
func _ready():
	trans.play("blank")
	trans.stop
	

func _process(_delta):
	interaction_system()
	
	if test_toggle > 1:
		test_toggle = 0
	
	if transition == false and trans.is_playing() == true:
		trans.play("blank")
		trans.stop

	$TysonView.offset = Vector2(randi_range(-Globals.shake, Globals.shake), randi_range(-Globals.shake, Globals.shake))
	
	if Input.is_action_pressed("testTog"):
	#	test_toggle = test_toggle + 1
		#emit_signal("RuinsMusic")
		#var timer : Timer = Timer.new()
		#add_child(timer)
		#timer.one_shot = true
		#timer.autostart = false
		#timer.wait_time = 2
		#timer.timeout.connect(func(): print("idiot"))
		#timer.start()
		#print("you... IDIOT")
		($"tyson-sprite" as AnimatedSprite2D).stop()
		global.tyson_input = false
		transition = true
		trans.play("transition in")
		var timer : Timer = Timer.new()
		add_child(timer)
		timer.one_shot = true
		timer.autostart = false
		timer.wait_time = 0.5
		timer.timeout.connect(func(): 
			global_position = scene_sw_ruins.ruins_5.global_position
			#look i was going to do this cool array but honestly i cba
			View.limit_top = scene_sw_ruins.ruins_5.cam_pos[0]
			View.limit_right = scene_sw_ruins.ruins_5.cam_pos[1]
			View.limit_bottom = scene_sw_ruins.ruins_5.cam_pos[2]
			View.limit_left = scene_sw_ruins.ruins_5.cam_pos[3]
			trans.play("transition out")
			global.tyson_input = true
			var timer2 : Timer = Timer.new()
			add_child(timer2)
			timer2.one_shot = true
			timer2.autostart = false
			timer2.wait_time = 0.5
			timer2.timeout.connect(func(): 
				transition = false
				global.tyson_input = true
			)
			timer2.start()
			
		
		)
		timer.start()
		pass
	
	#if test_toggle == 1:
	#	global.tyson_input = false
	#else:
	#	global.tyson_input = true
	
	if global.tyson_input == true:
		($"tyson-sprite" as AnimatedSprite2D).play(tyson_anim)
		
		if Input.is_action_pressed("sprint"):
			tyson_speed = 3.5
		else:
			tyson_speed = 1.3
	
		if Input.is_action_pressed("left"):
			move_and_collide(Vector2(-tyson_speed,0))
			tyson_anim = "left"
		elif Input.is_action_pressed("right"):
			move_and_collide(Vector2(tyson_speed,0))
			tyson_anim = "right"
		if Input.is_action_pressed("down"):
			move_and_collide(Vector2(0,tyson_speed))
			tyson_anim = "down"
		elif Input.is_action_pressed("up"):
			move_and_collide(Vector2(0,-tyson_speed))
			tyson_anim = "up"
		
		if !Input.is_action_pressed("up") and !Input.is_action_pressed("down") and !Input.is_action_pressed("left") and !Input.is_action_pressed("right"):
			($"tyson-sprite" as AnimatedSprite2D).stop()
	
	
		
	


		


func _on_coral_cutscene_ruins_animation_finished(anim_name):
	global.tyson_input = true
		
		
#breaks if you touch, pls don't
func _on_ruins_coral_cut_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if Input.is_action_pressed("up") and global.tyson_input == true and global.global_flag == 0 and global.room_move == true:
		print("touched") 
		emit_signal("Coral1")
		($"tyson-sprite" as AnimatedSprite2D).stop()

func _on_tyson_timer_timeout():
	pass

#yes finally a fucking scene switcher thank god
# (From hipxel): Soo i moved the scene switching system into the main scene switcher node at the top.


func _on_ruins_a_1_to_a_2_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if Input.is_action_pressed("up") and global.tyson_input == true:
		($"tyson-sprite" as AnimatedSprite2D).stop()
		global.tyson_input = false
		transition = true
		trans.play("transition in")
		var timer : Timer = Timer.new()
		add_child(timer)
		timer.one_shot = true
		timer.autostart = false
		timer.wait_time = 0.5
		timer.timeout.connect(func(): 
			global_position = scene_sw_ruins.ruins_2.global_position
			#look i was going to do this cool array but honestly i cba
			View.limit_top = scene_sw_ruins.ruins_2.cam_pos[0]
			View.limit_right = scene_sw_ruins.ruins_2.cam_pos[1]
			View.limit_bottom = scene_sw_ruins.ruins_2.cam_pos[2]
			View.limit_left = scene_sw_ruins.ruins_2.cam_pos[3]
			trans.play("transition out")
			global.tyson_input = true
			var timer2 : Timer = Timer.new()
			add_child(timer2)
			timer2.one_shot = true
			timer2.autostart = false
			timer2.wait_time = 0.5
			timer2.timeout.connect(func(): 
				transition = false
				global.tyson_input = true
			)
			timer2.start()
			
		
		)
		timer.start()

func _on_ruins_a_2_to_a_3_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if Input.is_action_pressed("up") and global.tyson_input == true:
		($"tyson-sprite" as AnimatedSprite2D).stop()
		global.tyson_input = false
		transition = true
		trans.play("transition in")
		var timer : Timer = Timer.new()
		add_child(timer)
		timer.one_shot = true
		timer.autostart = false
		timer.wait_time = 0.5
		timer.timeout.connect(func(): 
			global_position = scene_sw_ruins.ruins_3.global_position
			#look i was going to do this cool array but honestly i cba
			View.limit_top = scene_sw_ruins.ruins_3.cam_pos[0]
			View.limit_right = scene_sw_ruins.ruins_3.cam_pos[1]
			View.limit_bottom = scene_sw_ruins.ruins_3.cam_pos[2]
			View.limit_left = scene_sw_ruins.ruins_3.cam_pos[3]
			trans.play("transition out")
			global.tyson_input = true
			var timer2 : Timer = Timer.new()
			add_child(timer2)
			timer2.one_shot = true
			timer2.autostart = false
			timer2.wait_time = 0.5
			timer2.timeout.connect(func(): 
				transition = false
				global.tyson_input = true
			)
			timer2.start()
			
		
		)
		timer.start()


func _on_ruins_a_3_to_a_4_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if Input.is_action_pressed("up") and global.tyson_input == true:
		($"tyson-sprite" as AnimatedSprite2D).stop()
		global.tyson_input = false
		transition = true
		trans.play("transition in")
		var timer : Timer = Timer.new()
		add_child(timer)
		timer.one_shot = true
		timer.autostart = false
		timer.wait_time = 0.5
		timer.timeout.connect(func(): 
			global_position = scene_sw_ruins.ruins_4.global_position
			#look i was going to do this cool array but honestly i cba
			View.limit_top = scene_sw_ruins.ruins_4.cam_pos[0]
			View.limit_right = scene_sw_ruins.ruins_4.cam_pos[1]
			View.limit_bottom = scene_sw_ruins.ruins_4.cam_pos[2]
			View.limit_left = scene_sw_ruins.ruins_4.cam_pos[3]
			trans.play("transition out")
			global.tyson_input = true
			var timer2 : Timer = Timer.new()
			add_child(timer2)
			timer2.one_shot = true
			timer2.autostart = false
			timer2.wait_time = 0.5
			timer2.timeout.connect(func(): 
				transition = false
				global.tyson_input = true
			)
			timer2.start()
			
		
		)
		timer.start()

var closest_interactable = null
var interactable_distance = 0
var interactables = []
func interaction_system():
	if Input.is_action_just_pressed("accept"):
		interactables = get_tree().get_nodes_in_group("interact")
		interactable_distance = INF
		for i in interactables:
			if global_position.distance_squared_to(i.global_position) < interactable_distance:
				interactable_distance = global_position.distance_squared_to(i.global_position)
				closest_interactable = i
				
		closest_interactable.interact()
				

func _on_ruins_a_4_to_a_5_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if Input.is_action_pressed("up") and global.tyson_input == true:
		($"tyson-sprite" as AnimatedSprite2D).stop()
		global.tyson_input = false
		transition = true
		trans.play("transition in")
		var timer : Timer = Timer.new()
		add_child(timer)
		timer.one_shot = true
		timer.autostart = false
		timer.wait_time = 0.5
		timer.timeout.connect(func(): 
			global_position = scene_sw_ruins.ruins_5.global_position
			#look i was going to do this cool array but honestly i cba
			View.limit_top = scene_sw_ruins.ruins_5.cam_pos[0]
			View.limit_right = scene_sw_ruins.ruins_5.cam_pos[1]
			View.limit_bottom = scene_sw_ruins.ruins_5.cam_pos[2]
			View.limit_left = scene_sw_ruins.ruins_5.cam_pos[3]
			trans.play("transition out")
			global.tyson_input = true
			var timer2 : Timer = Timer.new()
			add_child(timer2)
			timer2.one_shot = true
			timer2.autostart = false
			timer2.wait_time = 0.5
			timer2.timeout.connect(func(): 
				transition = false
				global.tyson_input = true
			)
			timer2.start()
			
		
		)
		timer.start()
