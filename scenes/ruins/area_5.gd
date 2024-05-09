extends Node2D

@onready var hack = $"../room5hackpos"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = hack.global_position
