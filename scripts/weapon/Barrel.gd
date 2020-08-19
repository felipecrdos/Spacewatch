extends Position2D
class_name Barrel

export (float) var firerate setget set_firerate
var sfirerate : float
export (PackedScene) var ammo

func set_firerate(value : float):
	firerate = value
	sfirerate = firerate
	
func shoot():
	firerate -= 1
	if firerate <= 0:
		var new = ammo.instance()
		new.set_deferred("global_position", global_position)
		new.set_deferred("direction", Vector2(cos(rotation),sin(rotation)))
		Global.findnode("AmmoContainer").call_deferred("add_child", new)
		firerate = sfirerate
