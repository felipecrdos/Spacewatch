extends ParallaxBackground

export (Vector2) var space_speed
export (Vector2) var space_direction
export (Vector2) var starA_speed
export (Vector2) var starA_direction
export (Vector2) var starB_speed
export (Vector2) var starB_direction

var space_layer
var starA_layer
var starB_layer

func _ready():
	space_layer = $SpaceLayer
	starA_layer = $StarALayer
	starB_layer = $StarBLayer
	
func _physics_process(delta):
	scroll_space(delta)
	scrollA_star(delta)
	scrollB_star(delta)

func scroll_space(delta):
	space_layer.motion_offset += space_direction * space_speed * delta

func scrollA_star(delta):
	starA_layer.motion_offset += starA_direction * starA_speed * delta

func scrollB_star(delta):
	starB_layer.motion_offset += starB_direction * starB_speed * delta
