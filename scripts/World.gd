extends Node

var lviewport
var mviewport
var rviewport

var healths
var crystal
var hcrystal
var weapon
var powerup

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
	
	healths = $HContainer/LeftScreen/Viewport/VContainer/MidleVContainer/HContainer
	crystal = $HContainer/LeftScreen/Viewport/VContainer/BottVContainer/Crystals/GreenCrystal/Label
	hcrystal = $HContainer/LeftScreen/Viewport/VContainer/BottVContainer/Crystals/HGreenCrystal/Label
	weapon = $HContainer/LeftScreen/Viewport/VContainer/BottVContainer/Powerup/HContainer/Icon
	powerup = $HContainer/LeftScreen/Viewport/VContainer/BottVContainer/Powerup/Label
	
	boss_name = $HContainer/RightScreen/VContainer/TopVContainer/Label 
	boss_texture = $HContainer/RightScreen/VContainer/TopVContainer/HContainer/Icon
	level_name = $HContainer/RightScreen/VContainer/MidleVContainer/LevelName
	
	game_data = Global.game_data
	player_data = game_data["Player"]
	level_data = game_data["Level"]
	
	update_health(0)
	update_crystal(0)
	update_powerup(0)
	update_boss()
	update_level()
	add_level()
	
func update_health(value : int, body=null):
	player_data["health"] += value
	player_data["health"] = clamp(	player_data["health"], 
									0, player_data["maxhealth"])
	for t in healths.get_children():
		t.visible = false
		
	for h in player_data["health"]:
		var t = healths.get_child(h)
		t.visible = true
	if body:
		body.update_health()

func update_crystal(value : int):
	player_data["crystal"] += value
	var aux = [50, 150, 250, 400]
	# Change level index test
	if player_data["crystal"] != 0:
		if player_data["crystal"] == aux[level_data["index"]]:
			if Global.get_boss_state() == Global.WAITING:
				Global.set_boss_state(Global.FIGHTING)
				level.boss_path_move_down()
				
	if player_data["crystal"] > player_data["hcrystal"]:
		player_data["hcrystal"] = player_data["crystal"]
		
	crystal.text = str(player_data["crystal"])
	hcrystal.text = str(player_data["hcrystal"])

func update_powerup(value : int, body=null):
	player_data["powerup"] += value
	player_data["powerup"] = clamp(	player_data["powerup"], 
									0, player_data["maxpowerup"]-1)
	weapon.texture = load(player_data["weapon"][player_data["powerup"]])
	if body:
		body.update_weapon()

func update_boss():
	var index = level_data["index"]
	boss_name.text = level_data["boss"]["name"][index]
	boss_texture.texture = load(level_data["boss"]["texture"][index])

func update_level():
	var index = level_data["index"]
	level_name.text = level_data["name"][index]
	
func load_level():
	var index = level_data["index"]
	var path = level_data["path"]
	level = load(path[index]).instance()
	
func transition_level(time : float = 0.0):
	yield(get_tree().create_timer(time), "timeout")
	level.disable_player()
	Global.transition.start(0, 1, 1, 0);
	yield(Global.transition.tween, "tween_all_completed")
	remove_level()
	add_level()
	Global.transition.start(1, 0, 1, 0);

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


