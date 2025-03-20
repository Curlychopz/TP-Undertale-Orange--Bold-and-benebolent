extends Node


var playersave : SaveFile = null
var roomin = -1


func _ready():
	start()
	#loadgame()
	resetgame()
	
func loadgame():
	if(ResourceLoader.exists("user://saved.tres")):
		playersave = ResourceLoader.load("user://saved.tres").duplicate()
	else:
		resetgame()
func resetgame():
	playersave = SaveFile.new()
	savegame()

func savegame():
	ResourceSaver.save(playersave, "user://saved.tres")


func toggle_resolution():
	#switches between screen sizes
	match(DisplayServer.window_get_mode()):
		0:
			DisplayServer.window_set_mode(3)
			get_viewport().size = Vector2(1920,1080)
			DisplayServer.window_set_position(Vector2(Vector2(DisplayServer.screen_get_size() / 2) - Vector2(get_viewport().size / 2)))
		3:
			DisplayServer.window_set_mode(0)
			get_viewport().size = Vector2(640,480)
	changezoom()

func changezoom():
	var factor = Vector2(DisplayServer.screen_get_size())/Vector2(1920,1080)
	#switches zoom on the display system
	match(DisplayServer.window_get_mode()):
			0:
				globals.displaycam.zoom = Vector2(1,1)
				get_viewport().size = Vector2(640,480)
			3:
				globals.displaycam.zoom = Vector2(1,1) * factor


func start() -> void:
	RenderingServer.set_default_clear_color(Color.BLACK)
	DisplayServer.window_set_mode(0)
	get_viewport().size = Vector2(640,480)

func _process(delta):
	if Input.is_action_just_pressed("fullscreen") && !Input.is_action_just_pressed("alt"):
		toggle_resolution()
