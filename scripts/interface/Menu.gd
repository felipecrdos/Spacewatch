extends Node2D

var start
var quit
 
func _ready():
	start = $VBoxContainer/Start
	quit = $VBoxContainer/Quit
	start.grab_focus()

func on_start_send_scene(scene):
	get_tree().change_scene(scene)
	
func on_quit_send_scene(scene):
	get_tree().quit()
