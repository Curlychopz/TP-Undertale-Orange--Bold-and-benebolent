extends CanvasLayer

var current_dialogue = null
var dialogue_data = preload("res://dialouge/test_dialouge.tscn")
var dialogue_instance = null

var dialogue_index = 0
@onready var text = $node/rect/text

var text_ticker_timer = 0

var textbox_available_for_execution = false

func _ready():
	dialogue_instance = dialogue_data.instantiate()
	current_dialogue = dialogue_instance.get_children()[dialogue_index]
	
	text.text = str(current_dialogue.text)
	$node.scale = Vector2.ZERO
	Globals.tyson_input = false
	
func _physics_process(delta):
	if not textbox_available_for_execution:
		
		$node.scale += (Vector2.ONE - $node.scale) * 0.5
		# Gets the current dialouge node entry
		current_dialogue = dialogue_instance.get_children()[dialogue_index]
		
		text_ticker_timer -= current_dialogue.write_speed
		if text_ticker_timer < 0:
			text.visible_characters += 1
			text_ticker_timer = 1
		
		if Input.is_action_just_pressed("accept"):
			cycle_text()
		if Input.is_action_just_pressed("cancel"):
			text.visible_characters = current_dialogue.text.length() 
		if Input.is_action_pressed("inv"):
			text.visible_characters *= 2
			cycle_text()
	else:
		Globals.tyson_input = true
		$node.scale /= 3
		if $node.scale.length() < 0.1:
			queue_free()
			
	
func cycle_text():
	if text.visible_characters >= current_dialogue.text.length():
		if dialogue_index < dialogue_instance.get_children().size() - 1:
			dialogue_index += 1
			text.visible_characters = 0
			current_dialogue = dialogue_instance.get_children()[dialogue_index]
			text.text = str(current_dialogue.text)
		else:
			textbox_available_for_execution = true
			
			
		
