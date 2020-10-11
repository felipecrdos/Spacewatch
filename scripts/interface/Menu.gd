extends Control

var start
var quit
var option
 
func _ready():
	start = $VBoxContainer/Start
	quit = $VBoxContainer/Quit
	option = $VBoxContainer/Option
	
	SoundManager.fade_in_music("Menu")
	set_buttons_disabled(false)
	start.grab_focus()

func on_start_send_scene(scene):
	SoundManager.fade_out_music("Menu")
	set_buttons_disabled(true)
	Global.change_scene(scene)
	
func on_quit_send_scene(scene):
	SoundManager.fade_out_music("Menu")
	set_buttons_disabled(true)
	yield(get_tree().create_timer(2), "timeout")
	get_tree().quit()

func set_buttons_disabled(value:bool):
	start.set_deferred("disabled",value)
	quit.set_deferred("disabled",value)
	option.set_deferred("disabled", value)
	
func on_option_send_scene(scene):
	SoundManager.fade_out_music("Menu")
	set_buttons_disabled(true)
	Global.change_scene(scene)


func on_menu_tree_entered():
	pass
