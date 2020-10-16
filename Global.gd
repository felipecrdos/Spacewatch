extends Node

# Variáveis Globais.
onready var transition 	= preload("res://scenes/interface/Transition.tscn")
var player : Player

func _ready():
	transition = transition.instance();
	get_tree().root.call_deferred("add_child", transition);


# Save/Load game data
var game_path = "user://game_data.json"
var game_data = {	
					"Player":{	"name":"Player", 
								"health":25,
								"maxhealth":25,
								"shield":0,
								"maxshield":4,
								"shieldup":0, 
								"powerup":0,
								"maxpowerup":4, 
								"super":0,
								"maxsuper":4,
								"cscore":0,
								"hscore":0,
								"shieldinfo":{"name":"PlayerShield", "strength":0},
								"weapon":["res://assets/sprite/weapon/mg_side.png",
										  "res://assets/sprite/weapon/matter_side.png",
										  "res://assets/sprite/weapon/laser_side.png",
										  "res://assets/sprite/weapon/rocket_side.png"]
							},
					"Level":{	"difficulty":"Easy", 
								"boss":{"name":["Destroyer", 
												"Shatterer", 
												"Eradicator", 
												"Void Guardian"],
										"texture":["res://assets/sprite/boss/levelA_boss.png",
													"res://assets/sprite/boss/levelB_boss.png",
													"res://assets/sprite/boss/levelC_boss.png",
													"res://assets/sprite/boss/levelD_boss.png"]},
								"index":0,
								"name":["Phobos", "Deimos", "Tarvos", "Ymir"],
								"music":["LevelA", "LevelB", "LevelC", "LevelD"], 
								"hudcolor":["#01040c", "#021010", "#110104", "#140608"],
								"labelcolor":[	{"normal":"#66b4f2", "hover":"#a7d6fc"}, 
												{"normal":"#50bca1", "hover":"#78f4d5"}, 
												{"normal":"#d35fd3", "hover":"#fc95fc"}, 
												{"normal":"#d78269", "hover":"#faa890"}],
								"path":["res://scenes/levels/LevelA.tscn",
										"res://scenes/levels/LevelB.tscn",
										"res://scenes/levels/LevelC.tscn",
										"res://scenes/levels/LevelD.tscn"]
							}
				}
var default_game_data = game_data.duplicate(true)
func save_data():
	var file = File.new()
	file.open(game_path, File.WRITE)
	file.store_line(to_json(game_data))
	file.close()
	print("Save Game!!")
	
func load_data():
	var file = File.new()
	if !file.file_exists(game_path):
		return
	file.open(game_path, File.READ)
	game_data = parse_json(file.get_as_text())
	file.close()
	print("Load Game!!")

var option_path = "user://option_data.json"
var option_data = {
					"volume" : {"Master":0, "MusicBus":0, "SfxBus":0}
	}
func save_option():
	var file = File.new()
	file.open(option_path, File.WRITE)
	file.store_line(to_json(option_data))
	file.close()
	print("Save Option!!")
	
func load_option():
	var file = File.new()
	if !file.file_exists(option_path):
		return
	file.open(option_path, File.READ)
	option_data = parse_json(file.get_as_text())
	file.close()
	print("Load Option!!")
	
func load_default_data():
	game_data["Player"]["health"] 		= default_game_data["Player"]["health"]
	game_data["Player"]["shield"] 		= default_game_data["Player"]["shield"]
	game_data["Player"]["cscore"] 		= default_game_data["Player"]["cscore"]
	game_data["Player"]["super"] 		= default_game_data["Player"]["super"]
	game_data["Player"]["powerup"] 		= default_game_data["Player"]["powerup"]
	game_data["Player"]["shieldup"] 	= default_game_data["Player"]["shieldup"]

func new_game():
	game_data = default_game_data
	save_data()

func choose(values:Array):
	if !values.empty():
		randomize()
		return values[randi()%values.size()]
	return -1

func findnode(node:String):
	var root = get_tree().get_root()
	var find = null
	for n in root.get_children():
		find = n.find_node(node, true, false) 
		if find:
			break
	return find

func add_level_index():
	var index = game_data["Level"]["index"]
	var paths = game_data["Level"]["path"] #array
	if index < paths.size()-1:
		game_data["Level"]["index"] += 1
		return true
	return false
#==
func change_scene(scene : String, delay:float=0):
	transition.start(0, 1, 1, delay)
	yield(transition.tween, "tween_all_completed")
	VisualServer.set_default_clear_color(Color("#0f0119"))
	get_tree().change_scene(scene)
	transition.start(1, 0, 1, 0)
#==
func create_particle(packed : PackedScene, position : Vector2, texture:Texture):
	var particle = packed.instance()
	Global.findnode("EffectContainer").call_deferred("add_child", particle)
	particle.set_deferred("position", position)
	particle.set_particle_texture(texture)
	particle.set_deferred("emitting", true)
	
func create_popup(packed : PackedScene, position : Vector2, text : String, color : Color, outline_color:Color):
	var popup = packed.instance()
	Global.findnode("EffectContainer").call_deferred("add_child", popup)
	popup.set_deferred("position", position)
	popup.set_deferred("text", text)
	popup.set_deferred("color", color)
	popup.set_deferred("outline_color", outline_color)

func create_hit(packed : PackedScene, position : Vector2):
	var hit = packed.instance()
	Global.findnode("EffectContainer").call_deferred("add_child", hit)
	hit.set_deferred("position", position)

func create_pickup(packed : PackedScene, position : Vector2):
	var pickup = packed.instance()
	Global.findnode("PickupContainer").call_deferred("add_child", pickup)
	pickup.set_deferred("position", position)

func create_explosion(packed : PackedScene, position : Vector2, anim : String, scale : Vector2, speed : float = 20):
	var explosion = packed.instance()
	Global.findnode("EffectContainer").call_deferred("add_child", explosion)
	explosion.set_deferred("position", position)
	explosion.set_deferred("scale", scale)
	explosion.call_deferred("play", anim, speed)


func is_on_screen(position:Vector2, texture_size:Vector2, screen_size:Vector2=Vector2(236, 270)):
	var screen_width = screen_size.x
	var screen_height = screen_size.y
	var is_inside = true
	
	var texture_width = texture_size.x
	var texture_height = texture_size.y

	if position.x - texture_width/2 > screen_width:
		is_inside = false
	if position.x + texture_width/2 < 0:
		is_inside = false

	if position.y - texture_height/2 > screen_height:
		is_inside = false
	if position.y + texture_height/2 < 0:
		is_inside = false
		
	return is_inside
