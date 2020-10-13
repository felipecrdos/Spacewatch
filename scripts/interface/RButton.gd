extends Button
class_name RButton

export (String, FILE) var scene
signal send_scene(scene)

func on_button_pressed():
	SoundManager.play_sfx("SelectButton")
	emit_signal("send_scene", scene)

func on_button_focus_entered():
	SoundManager.play_sfx("ChooseButton")

func on_button_mouse_entered():
	grab_focus()
