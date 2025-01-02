extends Area2D


@onready var marker := $Marker2D
@onready var changers = get_parent().get_children()

@export var c_name: String
@export var id: int
@export var to_id : int

func _ready():
	body_entered.connect(room_change)

func room_change(body):
	print("hiiii")
	print(changers)
	if body is tyson:
		for x in changers:
			if x.id == to_id:
				Globals.tyson.trans_representation(x)
