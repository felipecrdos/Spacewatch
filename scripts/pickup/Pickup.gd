extends Area2D
class_name Pickup

var velocity : Vector2
var direction: Vector2
var speed	 : Vector2
var value : String

export (PackedScene) var particle
export (PackedScene) var popup

func _ready():
	velocity = Vector2.ZERO
	direction = Vector2.ZERO
	speed = Vector2.ZERO
	


