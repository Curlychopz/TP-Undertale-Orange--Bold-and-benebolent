extends Node2D

var sprite = self

var def = 0

var health = 200
var max_health = 200
var mercy = 0

var shake = 0

func _ready():
	sprite = get_children()[0]

func _physics_process(delta):
	if shake > 0:
		sprite.position.x = sin(Time.get_ticks_msec() * delta * 7) * shake
		shake /= 1.3
	
func damage(val = 5):
	var calculated_dmg = val - (def / 10)
	health -= val
	shake += 25
	
