extends Level
class_name LevelC

func _ready():
	SoundManager.fade_in_music("LevelC")
	skycolor.color = Color("#bd80ff")
	VisualServer.set_default_clear_color(Color("#9b40fe"))
