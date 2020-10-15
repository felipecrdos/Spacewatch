extends Control

var menu
var quit
var hscore
var score
 
func _ready():
	menu = $VBoxContainer/VBButtons/Menu
	quit = $VBoxContainer/VBButtons/Quit
	
	hscore = $VBoxContainer/VBScore/HBHScore/LHScore
	score = $VBoxContainer/VBScore/HBScore/LScore
	
	hscore.text = "%04d"%(Global.game_data["Player"]["hscore"])
	score.text = "%04d"%(Global.game_data["Player"]["cscore"])
	
	menu.grab_focus()

func on_menu_send_scene(scene):
	SoundManager.fade_out_music("Victory")
	Global.change_scene(scene)
	
func on_quit_send_scene(scene):
	SoundManager.fade_out_music("Victory")
	yield(get_tree().create_timer(2), "timeout")
	get_tree().quit()

func set_buttons_disabled(value:bool):
	menu.set_deferred("disabled",value)
	quit.set_deferred("disabled",value)
	
func on_victory_tree_entered():
	SoundManager.fade_in_music("Victory")
