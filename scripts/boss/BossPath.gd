extends Path2D

var index : int
var speed : float
var follow : PathFollow2D
var level_data : Dictionary

func _ready():
	speed = 45
	follow = $Follow
	index = level_data["index"]
	level_data = Global.game_data["Level"]

func _physics_process(delta):
	follow.offset += speed * delta
	
	if level_data["boss"]["state"][index] == Global.FIGHTING:
		position.y += 20 * delta
		pass
	
	
