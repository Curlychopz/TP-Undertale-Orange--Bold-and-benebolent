extends CharacterBody2D

class_name tyson

var tyson_anim = "down"
var tyson_speed = 1.3
var test_toggle = 0
var tyson_input = true  
var cutsNum = 0
var transition = false
@export var speed = 100
@onready var anim_tree = $AnimationTree
@onready var state = anim_tree.get("parameters/playback")
@onready var tycamtop = $TysonView.limit_top
@onready var tycambottom = $TysonView.limit_bottom
@onready var tycamleft = $TysonView.limit_left
@onready var tycamright = $TysonView.limit_right
signal Coral1
signal in_trans_1
signal RuinsMusic

@export var tele_pos: Vector2
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
	globals.tyson_input = false
	globals.global_flag = globals.global_flag + 1
	globals.in_cutscene = true
	
func trans_representation(room):
	if globals.tyson_input == true:
		state.travel("idle")
		globals.tyson_input = false
		transition = true
		trans.play("transition in")
		var timer : Timer = Timer.new()
		add_child(timer)
		timer.one_shot = true
		timer.autostart = false
		timer.wait_time = 0.5
		timer.timeout.connect(func(): 
			global_position = room.marker.global_position
#			#look i was going to do this cool array but honestly i cba
#			View.limit_top = scene_sw_ruins.room.cam_pos[0]
#			View.limit_right = scene_sw_ruins.room.cam_pos[1]
#			View.limit_bottom = scene_sw_ruins.room.cam_pos[2]
#			View.limit_left = scene_sw_ruins.room.cam_pos[3]
			trans.play("transition out")
			globals.tyson_input = true
			var timer2 : Timer = Timer.new()
			add_child(timer2)
			timer2.one_shot = true
			timer2.autostart = false
			timer2.wait_time = 0.5
			timer2.timeout.connect(func(): 
				transition = false
				globals.tyson_input = true
			)
			timer2.start()
				
			
		)
		timer.start()
	
func _ready():
	pass;
	globals.cam = $TysonView
	globals.tyson = self
	trans.play("blank")
	trans.stop
	

func _process(_delta):
	interaction_system()
	if test_toggle > 1:
		test_toggle = 0
	
	if transition == false and trans.is_playing() == true:
		trans.play("blank")
		trans.stop

	$TysonView.offset = Vector2(randi_range(-globals.shake, globals.shake), randi_range(-globals.shake, globals.shake))
	#if test_toggle == 1:
	#	global.tyson_input = false
	#else:
	#	global.tyson_input = true
	
	if globals.tyson_input == true:
		
		if Input.is_action_pressed("sprint"):
			tyson_speed = 3.5
		else:
			tyson_speed = 1.3
		var direction = Vector2(
			Input.get_action_strength("right") - Input.get_action_strength("left"),
			Input.get_action_strength("down") - Input.get_action_strength("up")
		)
		
		update_animation_parameters(direction)
		
		velocity = direction * speed *tyson_speed
		
		move_and_slide()
		#if Input.is_action_pressed("left"):
			#move_and_collide(Vector2(-tyson_speed,0))
			#tyson_anim = "left"
		#elif Input.is_action_pressed("right"):
			#move_and_collide(Vector2(tyson_speed,0))
			#tyson_anim = "right"
		#if Input.is_action_pressed("down"):
			#move_and_collide(Vector2(0,tyson_speed))
			#if velocity.x == 0:
				#tyson_anim = "down"
		#elif Input.is_action_pressed("up"):
			#move_and_collide(Vector2(0,-tyson_speed))
			#if velocity.x == 0:
				#tyson_anim = "up"
		#
		#if !Input.is_action_pressed("up") and !Input.is_action_pressed("down") and !Input.is_action_pressed("left") and !Input.is_action_pressed("right"):
			#($"tyson-sprite" as AnimatedSprite2D).stop()
	
	
		
	
func update_animation_parameters(move_input : Vector2):
	if (move_input != Vector2.ZERO):
		if abs(anim_tree.get("parameters/walk/blend_position").x) ==1  and abs(move_input.y) ==1:
			pass
		else:
			anim_tree.set("parameters/walk/blend_position", move_input)
			anim_tree.set("parameters/idle/blend_position", move_input)
		if (move_input.x ==0 and abs(anim_tree.get("parameters/walk/blend_position").x) ==1) or (move_input.x == -1 *anim_tree.get("parameters/walk/blend_position").x):
			anim_tree.set("parameters/walk/blend_position", move_input)
			anim_tree.set("parameters/idle/blend_position", move_input)
	if(velocity != Vector2.ZERO):
		state.travel("walk")
	else:
		state.travel("idle")
		


func _on_coral_cutscene_ruins_animation_finished(anim_name): 
	globals.tyson_input = true 
		
		
#breaks if you touch, pls don't
func _on_ruins_coral_cut_body_shape_entered(body_rid, body, body_shape_index, local_shape_index): 
	if Input.is_action_pressed("up") and globals.tyson_input == true and globals.global_flag == 0 and globals.room_move == true: 
		print("touched") 
		emit_signal("Coral1") 
		state.travel("idle")

#yes finally a fucking scene switcher thank god
# (From hipxel): Soo i moved the scene switching system into the main scene switcher node at the top.


var closest_interactable = null
var interactable_distance = 0
var interactables = []
func interaction_system():
	if Input.is_action_just_pressed("accept"):
		interactables = get_tree().get_nodes_in_group("interact")
		interactable_distance = INF
		for i in interactables:
			if global_position.distance_squared_to(i.global_position) < interactable_distance:
				interactable_distance = global_position.distance_to(i.global_position)
				closest_interactable = i
		if interactable_distance <=50:
			state.travel("idle")
			closest_interactable.interact()
