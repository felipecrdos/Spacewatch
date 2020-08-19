extends Node2D

var resume
var menu

func _ready():
	resume = $VContainer/Resume
	menu = $VContainer/Menu

func _input(event):
	if event is InputEventKey:
		if Input.is_key_pressed(KEY_P):
			resume.grab_focus()
			set_visible(true)
			get_tree().paused = true
			
func on_resume_send_scene(scene):
	set_visible(false)
	get_tree().paused = false

func on_menu_send_scene(scene):
	set_visible(false)
	get_tree().paused = false
	get_tree().change_scene(scene)
