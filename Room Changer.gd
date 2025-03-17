extends Area2D


@onready var marker := $Marker2D
@onready var changers = get_parent().get_children()


@export var nodeswitch := false

@export var c_name: String
@export var id: int
@export var to_id : int

@export var camtop: int
@export var cambottom: int
@export var camleft: int
@export var camright: int


func _ready():
	body_entered.connect(room_change)

func room_change(body):
	if body is tyson:
		for x in changers:
			if x.id == to_id:
				globals.tyson.trans_representation(x)
				globals.tyson.tycambottom = cambottom
				globals.tyson.tycamtop = camtop
				globals.tyson.tycamleft = camleft
				globals.tyson.tycamright = camright
