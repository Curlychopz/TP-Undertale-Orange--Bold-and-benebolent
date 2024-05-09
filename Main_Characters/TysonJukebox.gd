extends AudioStreamPlayer2D

@onready var global = get_node("/root/Globals")

var song_on = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.song_playing == "ruins1" && global.song_override == false && song_on == false:
		playing = true
		autoplay = true
		song_on = true
		
		if global.song_playing != "ruins1":
			song_on = false
			playing = false
			autoplay = false


#func _on_tysonbody_ruins_music():
	#print("working")
	#playing = true
	#autoplay = true
	


func _on_tyson_ruins_music():
	print("working")
	playing = true
	autoplay = true


func _on_finished():
	song_on = false
