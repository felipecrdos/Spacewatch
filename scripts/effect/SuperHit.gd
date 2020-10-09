extends Node2D
class_name SuperHit

func _ready():
	$ASprite.play("default")
	
func on_animation_finished():
	queue_free()
