extends Node2D

var counter = 0
var center = Vector2(160, 120)

func _draw():
	draw_circle(center, center.length_squared(), Color8(0,12,32))
	for i in range(32):
		var counter_calc = sin(counter * (i * 0.4)) * 2
		draw_arc(center + Vector2(sin(counter_calc), cos(counter_calc)) * i, (16 * i), -PI, PI,  360, Color8(0,44,84), 1.0 + sin(counter_calc))
		

func _physics_process(delta):
	counter += delta
	queue_redraw()
	
