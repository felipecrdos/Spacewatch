extends Node2D
class_name Level

var level
var difficulty
var boss
var skycolor

func _ready():
	skycolor = $Background/SkyColor
	skycolor.color = Color("#28a0ff")
	VisualServer.set_default_clear_color(Color("#0089ff"))
