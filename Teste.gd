extends Path2D


func _ready():
	pass

func _physics_process(delta):
	$PathFollow2D.offset += 40 * delta
