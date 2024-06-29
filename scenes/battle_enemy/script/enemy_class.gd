extends Node2D
class_name enemy

var id = 1

var sprite = self

var def = 0

var health = 200
var max_health = 200
var mercy = 0

var shake = 0

func _ready():
	sprite = get_children()[0]

	
func _enter_tree():
	var healthbar_inst = preload("res://scenes/battle_enemy/resources/enemy_healthbar.tscn").instantiate()
	healthbar_inst.position =  sprite.position
	add_child(healthbar_inst)
	healthbar_inst.process_delay = id * 2
	
	
func _physics_process(delta):
	if shake > 0:
		sprite.position.x = sin(Time.get_ticks_msec() * delta * 7) * shake
		shake /= 1.3
		
	
func damage(val = 5):
	var calculated_dmg = val - (def / 10)
	health -= val
	shake += 25
	
