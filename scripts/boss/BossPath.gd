extends Path2D

var speed : float
var follow : PathFollow2D

func _ready():
	follow = $Follow
	speed = 45

func _physics_process(delta):
	follow.offset += speed * delta
