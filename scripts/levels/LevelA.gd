extends Level
class_name LevelA

func _ready():
	wakeup_boss(30)
	SoundManager.fade_in_music("LevelA")
	skycolor.color = Color("#28a0ff")
	VisualServer.set_default_clear_color(Color("#0089ff"))
