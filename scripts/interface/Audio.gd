extends Control

var menu 
var back
func _ready():
	menu = $VBAudio/HBButtons/Menu
	back = $VBAudio/HBButtons/Back
	
	SoundManager.fade_in_music("Menu")
	set_buttons_disabled(false)
	menu.grab_focus()

func on_menu_send_scene(scene):
	SoundManager.fade_in_music("Menu")
	set_buttons_disabled(true)
	Global.change_scene(scene)
	
func on_back_send_scene(scene):
	SoundManager.fade_in_music("Menu")
	set_buttons_disabled(true)
	Global.change_scene(scene) 
	
func set_buttons_disabled(value:bool):
	menu.set_deferred("disabled",value)
	back.set_deferred("disabled",value)

func on_audiovolume_tree_exited():
	Global.save_option()
