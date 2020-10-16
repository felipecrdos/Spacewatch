extends Node

var lviewport
var mviewport
var rviewport

var health
var shield
var curr_score
var high_score
var weapon
var powerup
var super

var boss_name 
var boss_texture
var level_name

var game_data
var player_data
var level_data
var level
var pause

func _ready():
	add_to_group("world")
	
	pause = $Pause
	lviewport = $HContainer/LeftScreen/Viewport
	mviewport = $HContainer/MidleScreen/Viewport
	rviewport = $HContainer/RightScreen/Viewport
	
	health = $HContainer/LeftScreen/Viewport/VContainer/HealthContainer/MHealth/VBHealth/HBHealth/LHealth
	shield = $HContainer/LeftScreen/Viewport/VContainer/HealthContainer/MShield/HBShield/LShield
	curr_score = $HContainer/LeftScreen/Viewport/VContainer/ScoreContainer/MScore/VBScore/HBCurrentScore/LScore
	high_score = $HContainer/LeftScreen/Viewport/VContainer/ScoreContainer/MScore/VBScore/HBHighScore/LScore
	weapon = $HContainer/LeftScreen/Viewport/VContainer/PlayerContainer/HBPlayer/MPlayer/IGun/Sprite
	powerup = $HContainer/LeftScreen/Viewport/VContainer/PowerContainer/MPowerup/VBPowerup/HBPowerup/LPowerup
	super = $HContainer/LeftScreen/Viewport/VContainer/PowerContainer/MSuper/HBSuper/LSuper
	boss_name = $HContainer/RightScreen/Viewport/VContainer/VBBoss/TBoss
	boss_texture = $HContainer/RightScreen/Viewport/VContainer/VBBoss/IBoss
	level_name = $HContainer/RightScreen/Viewport/VContainer/MidleVContainer/LevelName
	
	game_data = Global.game_data
	player_data = game_data["Player"]
	level_data = game_data["Level"]
	
	update_health(0)
	update_shield(0)
	update_score(0)
	update_powerup(0)
	update_super(0)
	update_boss()
	update_level()
	add_level()
	
func update_health(value : int, body=null):
	player_data["health"] += value
	player_data["health"] = clamp(	player_data["health"], 
									0, player_data["maxhealth"])

	health.text = str(player_data["health"])
	if body:
		body.update_health()

func update_shield(value : int, body=null):
	player_data["shield"] += value
	player_data["shield"] = clamp(	player_data["shield"], 
									0, player_data["maxshield"])
	shield.text = str(player_data["shield"])
	if body:
		body.update_shield()

func update_score(value : int):
	player_data["cscore"] += value
	if player_data["cscore"] > player_data["hscore"]:
		player_data["hscore"] = player_data["cscore"]
		
	curr_score.text = str(player_data["cscore"])
	high_score.text = str(player_data["hscore"])

func update_powerup(value : int, body=null):
	player_data["powerup"] += value
	player_data["powerup"] = clamp(	player_data["powerup"], 
									0, player_data["maxpowerup"]-1)
	powerup.text = str(player_data["powerup"])
	weapon.texture = load(player_data["weapon"][player_data["powerup"]])
	if body:
		body.update_weapon()

func update_super(value : int, body=null):
	player_data["super"] += value
	player_data["super"] = clamp(	player_data["super"], 
									0, player_data["maxsuper"]-1)
	super.text = str(player_data["super"])
#	if body:
#		body.update_weapon()

func update_boss():
	var index = level_data["index"]
	boss_name.text = level_data["boss"]["name"][index]
	boss_texture.texture = load(level_data["boss"]["texture"][index])

func update_level():
	var index = level_data["index"]
	level_name.text = level_data["name"][index]

func boss_was_killed():
	SoundManager.fade_out_level_music(4)
	if Global.add_level_index():
		transition_level()
	else:
		Global.change_scene("res://scenes/interface/Victory.tscn", 4)
	
func load_level():
	var index = level_data["index"]
	var path = level_data["path"]
	level = load(path[index]).instance()
	
func transition_level():
	Global.transition.start(0, 1, 1, 4);
	yield(Global.transition.tween, "tween_all_completed")
	$Pause.set_buttons_color()
	remove_level()
	add_level()
	update_hudlabel_color()
	Global.transition.start(1, 0, 1, 0);

func update_hudlabel_color():
	for label in get_tree().get_nodes_in_group("hudlabel"):
		label.set_label_color()
		
# Add current level
func add_level():
	load_level()
	mviewport.add_child(level)
	update_boss()
	update_level()
	
func remove_level():
	for child in mviewport.get_children():
		if child is Level:
			child.free()

func on_world_tree_entered():
	Global.load_data()
	Global.load_default_data()
	
func on_world_tree_exited():
	Global.save_data()
