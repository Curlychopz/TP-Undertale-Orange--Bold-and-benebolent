extends Resource


class_name SaveFile

@export var player = {
	name = "tyson",
	lv = 1,
	currenthp = 20,
	max_hp = 20,
	atk = 0,
	def = 0,
	exp = 0,
	weapon = "",
	armor = "",
	gold = 0,
	kills = 0,
	fun = randi_range(0,100)
}
@export var inventory : Array = [
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
]
var roomdata = {
}

var rundata = {
	genocide = false,
	save_room= null,
	AreaName = "_",
}

func getnextxp():
	match player.lv:
		1:return 10
		2:return 30
		3:return 70
		4:return 120
		5:return 200
		6:return 300
		7:return 500
		8:return 800
		9:return 1200
		10:return 1700
		11:return 2500
		12:return 3500
		13:return 5000
		14:return 7000
		15:return 10000
		16:return 15000
		17:return 25000
		18:return 50000
		19:return 99999
		_:return null
