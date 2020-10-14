extends Node2D
class_name Weapon

var barrels : Array
#export (bool) var flash = true
#export (bool) var aim   = false

func _ready():
	get_barrels()

func get_barrels():
	for child in get_children():
		if child is Barrel:
			barrels.append(child)
func shoot():
	for barrel in barrels:
		barrel.shoot()
