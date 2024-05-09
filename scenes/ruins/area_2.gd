extends Node2D

@onready var global = get_node("/root/Globals") 

signal level_changed(level_name)

@export var level_name = "level"


func _on_tysonbody_in_trans_1():
	pass
	global.tyson_input = false
	emit_signal("level_changed")
	#global.tyson_input = true



# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_tyson_in_trans_1():
	pass # Replace with function body.
