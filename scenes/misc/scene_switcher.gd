extends Node

signal transition
@onready var TysonBody = $"tyson-body"
@onready var R1Init = $Ty_Pos_1_init
@onready var R2E = $Ty_Pos_2_Enter

var current_room = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$logo.connect("level_changed", self, "handle_level_changed")
	get_window().mode = Window.MODE_FULLSCREEN

func handle_level_changed(current_level_name):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

var scene_index_to_change = -1 # we leave it at -1 at first when we want it to stay idle.
var scene_switch_delay_start = 0.3
var scene_switch_delay_end = 0.3

func scene_switch_process(delta):
	if scene_index_to_change != -1:
		current_room.hide()
		
		
		
		
	
