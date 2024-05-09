extends CanvasLayer

var current_dialogue = null
var dialogue_data = preload("res://dialouge/test_dialouge.tscn")
var dialogue_instance = null

var dialogue_index = 0
@onready var text = $node/rect/text

var text_ticker_timer = 0

func _ready():
	get_window().mode = Window.MODE_FULLSCREEN
	dialogue_instance = dialogue_data.instantiate()
	current_dialogue = dialogue_instance.get_children()[dialogue_index]
	
	text.text = str(current_dialogue.text)
	$node.scale = Vector2.ZERO
	
func _physics_process(delta):
	
	$node.scale += (Vector2.ONE - $node.scale) * 0.2
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
		
	
func cycle_text():
	if text.visible_characters >= current_dialogue.text.length():
		if dialogue_index < dialogue_instance.get_children().size() - 1:
			dialogue_index += 1
			text.visible_characters = 0
			current_dialogue = dialogue_instance.get_children()[dialogue_index]
			text.text = str(current_dialogue.text)
			
			
		
