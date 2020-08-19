extends Sprite

var texture_width
var texture_height
var screen_width
var screen_height
var offsetx
var offsety

export (Vector2) var speed
export (Vector2) var delay

func _ready():
	texture_width = texture.get_width()
	texture_height = texture.get_height()
	
	screen_width = get_viewport_rect().size.x
	screen_height = get_viewport_rect().size.y
	
	offsetx = 0
	offsety = 0
	if delay.x != 0:
		offsetx = screen_width * delay.x
	if delay.y != 0:
		offsety = screen_height * delay.y

func _physics_process(delta):
	global_position.x += speed.x
	global_position.y += speed.y
	
	if speed.x > 0:
		if global_position.x > texture_width:
			global_position.x = -(texture_width + offsetx)
	elif speed.x < 0:
		if global_position.x < -texture_width:
			global_position.x = texture_width + offsetx
	if speed.y > 0:
		if global_position.y > texture_height:
			global_position.y = -(texture_height + offsety)
	elif speed.y < 0:
		if global_position.y < -texture_height:
			global_position.y = texture_height + offsety
