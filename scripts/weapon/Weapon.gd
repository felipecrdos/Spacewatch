extends Node2D
class_name Weapon

var barrels : Array
func _ready():
	pass
	
	for child in get_children():
		if child is Barrel:
			barrels.append(child)

func shoot():
	for barrel in barrels:
		barrel.shoot()
