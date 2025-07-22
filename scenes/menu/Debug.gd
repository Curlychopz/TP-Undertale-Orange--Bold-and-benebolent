extends TextEdit

var command 
@export var autofill :RichTextLabel
var commandlist : Array[String]= ["tp"]
func _ready() -> void:
	pass




func _process(delta: float) -> void:
	command = text.strip_edges().split(" ")
	if text != "":
		autofills(command)
	if Input.is_action_just_pressed("Enter"):
		print(command)
		executecommand(command)
		text = ""
	pass

func autofills(stext : Array[String]):
	if stext.size() == 1:
		for x in commandlist:
			if x.contains(stext[0]):
				autofill.text = x
				break
	elif stext[0] == "tp":
		var locations = get_tree().get_nodes_in_group("chanegrs")
		for x in locations:
			if x.c_name.begins_with(stext[1]):
				autofill.text = "tp " + x.c_name
				
		

func executecommand(stext : Array[String]):
	match text[0]:
		"tp":
			teleport(stext[1])
		_:
			pass

func teleport(loc : String):
	var locations = get_tree().get_nodes_in_group("chanegrs")
	for x in locations:
		if x.c_name == loc:
			globals.tyson.global_position = x.spawn.global_position
	
