extends Node2D

signal begin
signal level_changed(level_name)

@export var level_name = "Intro"

@onready var global = get_node("/root/Globals") 




func _ready():
	($"logo-timer" as Timer).one_shot = true;
	($"logo-timer" as Timer).wait_time = 1
	($"logo-timer" as Timer).start()

func _process(_delta):
	if ($"logo-sprite" as AnimatedSprite2D).frame != 3:
		if ($"logo-timer" as Timer).is_stopped():
			($"logo-sprite" as AnimatedSprite2D).frame += 1
			($"logo-timer" as Timer).one_shot = true;
			($"logo-timer" as Timer).wait_time = 1.8
			($"logo-timer" as Timer).start()
			if ($"logo-sprite" as AnimatedSprite2D).frame != 3:
				($"logo-sound" as AudioStreamPlayer).play()
				
	if ($"logo-sprite" as AnimatedSprite2D).frame == 3:
		if Input.is_action_just_pressed("accept"):
			#emit_signal("level_changed")
			get_tree().change_scene_to_file("res://scenes/menu/menu_begin.tscn")
 # robin? he has a yeeyee ass hair cut
