extends AnimationPlayer

signal change_scene

@onready var global = get_node("/root/Globals") 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.in_transition == true and global.tyson_input == true:
		global.tyson_input = false
		play("transition")
		
	if global.out_transition == true and global.tyson_input == false:
		play("transition_2")
		global.in_transition = false
		global.out_transition = false
	pass


func _on_transition_room_animate_trans():
	global.tyson_input = false
	play("transition")
	
