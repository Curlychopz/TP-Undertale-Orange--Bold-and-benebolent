extends Node2D


signal level_changed(level_name)

@export var level_name = "level"

@onready var global = get_node("/root/Globals") 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_tysonbody_in_trans_1():
	global.tyson_input = false
	#emit_signal("level_changed")
	get_tree().change_scene_to_file("res://scenes/ruins/area_2.tscn")
	
	#global.tyson_input = true
