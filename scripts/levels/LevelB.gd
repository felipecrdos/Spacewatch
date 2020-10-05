extends Level
class_name LevelB

func _ready():
	wakeup_boss(60)
	SoundManager.fade_in_music("LevelB")
	skycolor.color = Color("#ffab61")
	VisualServer.set_default_clear_color(Color("#ff8c26"))
