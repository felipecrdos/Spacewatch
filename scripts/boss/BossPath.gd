extends Path2D

var index : int
var speed : float
var follow : PathFollow2D
var level_data : Dictionary
var screen_width : float
var screen_height : float

func _ready():
	speed = 45
	follow = $Follow
	index = level_data["index"]
	level_data = Global.game_data["Level"]
	
	screen_width = get_viewport_rect().size.x
	screen_height = get_viewport_rect().size.y
	position.x = screen_width/2
	position.y = -screen_height/2
	
func _physics_process(delta):
	follow.offset += speed * delta
	
	
