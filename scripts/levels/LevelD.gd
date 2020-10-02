extends Level
class_name LevelD

func _ready():
	SoundManager.fade_in_music("LevelD")
	skycolor.color = Color("#4c42ff")
	VisualServer.set_default_clear_color(Color("#4139d0"))
