extends Node


class_name Display_System

signal DoneFading
signal LoadingRoom

@onready var camera = $Camera2D
@onready var game = $game
@onready var game_viewport := $game/SubViewportContainer/SubViewport
@onready var trans = $game/SubViewportContainer/SubViewport/Transition
@onready var tyson = $"game/SubViewportContainer/SubViewport/tyson-body"
var currentscene = null
var cameraintensity := 0.0
var shaketime := 0.0
var startingscene = load("res://scenes/ruins/area_1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	globals.display = self
	change_scene(startingscene, false)

func change_scene(path : Variant, fadeout = true,enter = true) -> Node:
	#Removes all current scenes in the display system
	if currentscene != null:
		currentscene.queue_free()
	#loads new scene
	var scene = path.instantiate()
	currentscene = scene
	game_viewport.add_child(scene)
	tyson.global_position = scene.enter.global_position
	#what if ninja got a low taper fade
	if(fadeout):
		trans.play("transition in")
	await get_tree().process_frame
	#Removes all camera shaking present
	cameraintensity = 0.0
	#currently unused 
	LoadingRoom.emit()
	return scene

	
