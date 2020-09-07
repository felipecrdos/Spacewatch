extends Node2D

var menu
var quit
 
func _ready():
	menu = $VBoxContainer/Menu
	quit = $VBoxContainer/Quit
	menu.grab_focus()

func on_menu_send_scene(scene):
	Global.change_scene(scene)
	
func on_quit_send_scene(scene):
	get_tree().quit()
