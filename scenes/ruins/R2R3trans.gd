extends Area2D



@onready var global = get_node("/root/Globals") 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.in_transition == true:
		pass
	pass




