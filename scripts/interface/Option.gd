extends Control

var menu
func _ready():
	menu = $VBContainer/HBButtons/Menu
	
	SoundManager.fade_in_music("Menu")
	set_buttons_disabled(false)
	menu.grab_focus()

func on_menu_send_scene(scene):
	SoundManager.fade_in_music("Menu")
	set_buttons_disabled(true)
	Global.change_scene(scene)

func set_buttons_disabled(value:bool):
	menu.set_deferred("disabled",value)

func on_audiovolume_tree_exited():
	Global.save_option()

func on_audio_send_scene(scene):
	SoundManager.fade_out_music("Menu")
	set_buttons_disabled(true)
	Global.change_scene(scene)
	
func on_controller_send_scene(scene):
	SoundManager.fade_out_music("Menu")
	set_buttons_disabled(true)
	Global.change_scene(scene)

func on_item_send_scene(scene):
	SoundManager.fade_out_music("Menu")
	set_buttons_disabled(true)
	Global.change_scene(scene) 
