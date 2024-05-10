extends StaticBody2D

@export var interactable_once = false
@export var text_only = true
@export var interact_text = preload("res://dialouge/test_dialouge.tscn")

var interacted = false
var interact_toggle = false
var times_interacted = 0

func interact():
	Globals
	if Globals.tyson_input:
		if text_only:
			Globals.dialouge_make(interact_text)
		else:
			interacted = true
			interact_toggle = !interact_toggle
			times_interacted += 1
			Globals.shake = 55
		
