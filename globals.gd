extends Node
var tyson_input = true
var global_flag = 0
var in_cutscene = false
var in_transition = false
var out_transition = false
var song_playing = "undefined"
var song_override = false
var room_move = true
#var TysonData = [true, 20, "Default"]
signal Ruins1

var shake = 0
var battle_data = self

# PLAYER DATA =============================
var hp = 20
var max_hp = 20

var def = 1
var item = []

# Called when the node enters the scene tree for the first time.
func _ready():
	#tyson_input = true
	global_flag = 0
	#in_cutscene = false
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# -Make sure player cant move when in cutscene-
	if in_cutscene == true:
		tyson_input = false
		
	# -Shake dampening-
	Globals.shake /= 1.3
	
var dialouge_ui = preload("res://dialouge/dialouge_ui.tscn")

func sfx(stream = preload("res://sounds/PC Computer - Undertale - Sound Effects/snd_damage.wav"), pos = Vector2.ZERO ):
	pass

func dialouge_make(dlg_data):
	var dialouge_ui_inst = dialouge_ui.instantiate()
	add_child(dialouge_ui_inst)
	
	
	#match song_playing:
		#"undefined":
			#print("silent")
		#"ruins1":
			#print("ruins1")
		#_:
			#print("minor spelling mistake :nerdemoji:")
			
