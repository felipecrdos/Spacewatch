extends Label

var colors
var index
var normal

func _ready():
	add_to_group("hudlabel")
	set_label_color()
	
func set_label_color():
	colors = Global.game_data["Level"]["labelcolor"] 
	index = Global.game_data["Level"]["index"]
	normal = Color(colors[index]["normal"])
	add_color_override("font_color", normal)
