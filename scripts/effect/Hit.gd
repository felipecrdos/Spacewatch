extends Node2D
class_name Hit

func _ready():
	$ASprite.play("default")
	
func on_animation_finished():
	queue_free()
