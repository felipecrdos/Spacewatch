# Cena que representa a tela de pause.
# A tecla 'P' pausa o game.
extends Node2D

var resume
var menu

func _ready():
	resume = $VContainer/Resume
	menu = $VContainer/Menu
	set_buttons_disabled(true)
	
func _input(event):
	if event is InputEventKey:
		if Input.is_key_pressed(KEY_P):
			SoundManager.pause_all_music()
			resume.grab_focus()
			set_visible(true)
			set_buttons_disabled(false)
			get_tree().paused = true
			
func on_resume_send_scene(scene):
	SoundManager.resume_all_music()
	set_visible(false)
	set_buttons_disabled(true)
	get_tree().paused = false

func on_menu_send_scene(scene):
	set_visible(false)
	set_buttons_disabled(true)
	get_tree().paused = false
	Global.change_scene(scene)

func set_buttons_disabled(value:bool):
	resume.set_deferred("disabled",value)
	menu.set_deferred("disabled",value)
