extends Path2D

var follow : PathFollow2D
var screen_width : float
var screen_height : float
export (float) var speed = 50

func _ready():
	follow = $Follow
	screen_width = get_viewport_rect().size.x
	screen_height = get_viewport_rect().size.y
	position.x = screen_width/2
	position.y = -screen_height/2
	
func _physics_process(delta):
	follow.offset += speed * delta
	
	
