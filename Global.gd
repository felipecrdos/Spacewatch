extends Node

var player

# Save/Load game data
var game_path = "user://game_data.json"
var game_data = {	
					"Player":{	"name":"Player", 
								"health":4,
								"maxhealth":4, 
								"powerup":0,
								"maxpowerup":4, 
								"crystal":0,
								"weapon":["res://assets/sprite/weapon/mg_side.png",
										  "res://assets/sprite/weapon/matter_side.png",
										  "res://assets/sprite/weapon/laser_side.png",
										  "res://assets/sprite/weapon/rocket_side.png"]
							},
					"Level":{	"path":"res://scenes/levels/Level.tscn",
								"name":"Level", 
								"difficulty":"Easy", 
								"Boss":"RedRibbon"
							}
				}

func save_data():
	var file = File.new()
	file.open(game_path, File.WRITE)
	file.store_line(to_json(game_data))
	file.close()
	
func load_data():
	var file = File.new()
	file.open(game_path, File.READ)
	game_data = parse_json(file.get_as_text())
	file.close()

#===
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

#==
func create_particle(packed : PackedScene, position : Vector2, color : Color):
	var particle = packed.instance()
	Global.findnode("EffectContainer").call_deferred("add_child", particle)
	particle.set_deferred("position", position)
	particle.set_deferred("modulate", color)
	particle.set_deferred("emitting", true)

func create_popup(packed : PackedScene, position : Vector2, text : String, color : Color):
	var popup = packed.instance()
	Global.findnode("EffectContainer").call_deferred("add_child", popup)
	popup.set_deferred("position", position)
	popup.set_deferred("text", text)
	popup.set_deferred("color", color)

func create_crystal(packed : PackedScene, position : Vector2):
	var crystal = packed.instance()
	Global.findnode("PickupContainer").call_deferred("add_child", crystal)
	crystal.set_deferred("position", position)

func create_explosion(packed : PackedScene, position : Vector2, anim : String, scale : Vector2):
	var explosion = packed.instance()
	Global.findnode("EffectContainer").call_deferred("add_child", explosion)
	explosion.set_deferred("position", position)
	explosion.set_deferred("scale", scale)
	explosion.call_deferred("play", anim)
