extends AnimationPlayer


@onready var global = get_node("/root/Globals") 

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func after_scene():
	global.global_flag = global.global_flag + 1
	global.in_cutscene = false
	
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	#if Input.is_action_pressed("testTog"):
		#play("Coral cutscene")
		#print(global.in_cutscene)
		#print(global.global_flag)
		#print(global.tyson_input)
	


func _on_tyson_coral_1():
	global.tyson_input = false
	play("Coral cutscene")
	after_scene()
