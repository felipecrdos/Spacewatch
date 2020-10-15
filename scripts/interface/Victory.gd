extends Control

var credits
var hscore
var score
 
func _ready():
	credits = $VBoxContainer/VBButtons/Credits
	hscore = $VBoxContainer/VBScore/HBHScore/LHScore
	score = $VBoxContainer/VBScore/HBScore/LScore
	
	hscore.text = "%04d"%(Global.game_data["Player"]["hscore"])
	score.text = "%04d"%(Global.game_data["Player"]["cscore"])
	
	credits.grab_focus()

func on_credits_send_scene(scene):
	SoundManager.fade_out_music("Victory")
	Global.change_scene(scene)

func set_buttons_disabled(value:bool):
	credits.set_deferred("disabled",value)
	
	
func on_victory_tree_entered():
	SoundManager.fade_in_music("Victory")
