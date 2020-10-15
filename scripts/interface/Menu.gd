extends Control

var _continue
var quit
var options
 
func _ready():
	_continue = $VBoxContainer/VButtons/Continue
	quit = $VBoxContainer/VButtons/Quit
	options = $VBoxContainer/VButtons/Options
	
	SoundManager.fade_in_music("Menu")
	set_buttons_disabled(false)
	_continue.grab_focus()

func on_continue_send_scene(scene):
	SoundManager.fade_out_music("Menu")
	set_buttons_disabled(true)
	Global.change_scene(scene)
	
func on_quit_send_scene(scene):
	SoundManager.fade_out_music("Menu")
	set_buttons_disabled(true)
	yield(get_tree().create_timer(2), "timeout")
	get_tree().quit()

func set_buttons_disabled(value:bool):
	_continue.set_deferred("disabled",value)
	quit.set_deferred("disabled",value)
	options.set_deferred("disabled", value)
	
func on_options_send_scene(scene):
	SoundManager.fade_out_music("Menu")
	set_buttons_disabled(true)
	Global.change_scene(scene)


func on_new_game_send_scene(scene):
	SoundManager.fade_out_music("Menu")
	set_buttons_disabled(true)
	Global.new_game()
	Global.change_scene(scene)
	
