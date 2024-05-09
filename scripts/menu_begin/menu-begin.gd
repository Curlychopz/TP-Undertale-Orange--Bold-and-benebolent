extends Node2D

func _ready():
	pass

func _process(_delta):
	if !($"menu-music" as AudioStreamPlayer).playing:
		if ($"fadeout-sprite" as AnimatedSprite2D).visible == false:
			($"menu-music" as AudioStreamPlayer).play()
		
	if Input.is_action_just_pressed("accept"):
		if ($"fadeout-sprite" as AnimatedSprite2D).visible == false:
			($"menu-sprite" as AnimatedSprite2D).play()
			($"menu-music" as AudioStreamPlayer).stop()
			($"fadeout-sprite" as AnimatedSprite2D).visible = true
			($"fadeout-sprite" as AnimatedSprite2D).play()
			($"fadeout-sound" as AudioStreamPlayer).play()
			
	if ($"fadeout-sprite" as AnimatedSprite2D).visible == true:
		if !($"fadeout-sound" as AudioStreamPlayer).playing:
			get_tree().change_scene_to_file("res://scenes/ruins/area_1.tscn")
