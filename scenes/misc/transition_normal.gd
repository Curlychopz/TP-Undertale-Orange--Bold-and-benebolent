extends Node2D

signal animate_trans
signal new_room

@onready var global = get_node("/root/Globals") 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#func _on_trans_anim_animation_finished(anim_name):
	#global.tyson_input = true
	#global.in_transition = false
	#global.out_transition = true


func _on_scene_switcher_transition():
	emit_signal("animate_trans")



func _on_trans_anim_change_scene():
	emit_signal("new_room")


#func _on_trans_anim_animation_finished(transition):d
	#emit_signal("new_room")
