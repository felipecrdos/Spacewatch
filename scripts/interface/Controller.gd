extends Control

var start
var back 
func _ready():
	start = $VBController/HBButtons/Start
	back = $VBController/HBButtons/Back
	back.grab_focus()
	
	SoundManager.fade_in_music("Menu")
	set_buttons_disabled(false)


func on_start_send_scene(scene):
	SoundManager.fade_out_music("Menu")
	set_buttons_disabled(true)
	Global.change_scene(scene)
	 
func on_back_send_scene(scene):
	SoundManager.fade_out_music("Menu")
	set_buttons_disabled(true)
	Global.change_scene(scene)
	
func set_buttons_disabled(value:bool):
	start.set_deferred("disabled",value)
	back.set_deferred("disabled",value)
