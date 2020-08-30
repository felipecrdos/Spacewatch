extends Node

var lviewport
var mviewport
var rviewport

var healths
var crystal
var hcrystal
var weapon
var powerup

var game_data
var player_data
var level_data
var level

func _ready():
	add_to_group("world")
	
	lviewport = $HContainer/LeftScreen/Viewport
	mviewport = $HContainer/MidleScreen/Viewport
	rviewport = $HContainer/RightScreen/Viewport
	
	healths = $HContainer/LeftScreen/Viewport/VContainer/MidleVContainer/HContainer
	crystal = $HContainer/LeftScreen/Viewport/VContainer/BottVContainer/Crystals/GreenCrystal/Label
	hcrystal = $HContainer/LeftScreen/Viewport/VContainer/BottVContainer/Crystals/HGreenCrystal/Label
	weapon = $HContainer/LeftScreen/Viewport/VContainer/BottVContainer/Powerup/HContainer/Icon
	powerup = $HContainer/LeftScreen/Viewport/VContainer/BottVContainer/Powerup/Label
	
	game_data = Global.game_data
	player_data = game_data["Player"]
	level_data = game_data["Level"]
	
	update_health(0)
	update_crystal(0)
	update_powerup(0)
	change_level()
	
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
	
	# Change level index test
	if player_data["crystal"] == 50:
		level_data["index"] += 1
		change_level()
	
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
	
func load_level():
	var index = level_data["index"]
	var path = level_data["path"]
	level = load(path[index]).instance()
	
func change_level():
	Global.transition.start(0, 1, 1, 0);
	yield(Global.transition.tween, "tween_all_completed")
	remove_level()
	load_level()
	mviewport.add_child(level)
	Global.transition.start(1, 0, 1, 0);

func change_scene(scene : String):
	Global.transition.start(0, 1, 1, 0)
	yield(Global.transition.tween, "tween_all_completed")
	get_tree().change_scene(scene)
	Global.transition.start(1, 0, 1, 0)
		
func remove_level():
	for child in mviewport.get_children():
		if child is Level:
			child.free()

func on_world_tree_entered():
	Global.load_data()
	Global.load_default_data()
	
func on_world_tree_exited():
	Global.save_data()


