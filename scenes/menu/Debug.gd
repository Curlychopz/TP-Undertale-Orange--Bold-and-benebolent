extends TextEdit

var command 

func _ready() -> void:
	pass




func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Enter"):
		command = text.strip_edges().split(" ")
		print(command)
		executecommand(command)
		text = ""
	pass

func executecommand(text : Array[String]):
	match text[0]:
		"tp":
			teleport(text[1])
		_:
			pass

func teleport(loc : String):
	var locations = get_tree().get_nodes_in_group("chanegrs")
	for x in locations:
		if x.c_name == loc:
			globals.tyson.global_position = x.spawn.global_position
	
