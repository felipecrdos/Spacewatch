extends Area2D

var strength

func _ready():
	strength = 5

func destroy():
	queue_free()
	
func on_area_entered(area):
	SoundManager.play_sfx("PlayerHurt")
	if strength > 0:
		strength -= area.damage
	area.destroy()
	if strength <= 0:
		destroy()
	
func on_tree_exiting():
	Global.game_data["Player"]["shieldup"] = strength
