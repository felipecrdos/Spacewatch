# Cena que representa a tela de pause.
# A tecla 'P' pausa o game.
extends Control

var resume
var menu
var pause

func _ready():
	resume = $VContainer/VBButtons/Resume
	menu = $VContainer/VBButtons/Menu
	pause = $VContainer/TPause

	set_buttons_disabled(true)
	set_buttons_color()
	
func _input(event):
	if event is InputEventKey:
		if Input.is_key_pressed(KEY_P):
			SoundManager.pause_all_music()
			resume.grab_focus()
			set_visible(true)
			set_buttons_disabled(false)
			get_tree().paused = true
	

func set_buttons_color():
	var index = Global.game_data["Level"]["index"]
	var colors = Global.game_data["Level"]["hudcolor"]
	resume.add_color_override("font_color_hover", Color(colors[index]))
	resume.add_color_override("font_color_pressed", Color(colors[index]))
	menu.add_color_override("font_color_hover", Color(colors[index]))
	menu.add_color_override("font_color_pressed", Color(colors[index]))
	pause.add_color_override("font_color", Color(colors[index]))
	
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

func on_blink_timeout():
	pause.modulate.a = 1 if !pause.modulate.a else 0
