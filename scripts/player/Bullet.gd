extends Ammo

# Player Bullet
func _ready():
	damage = 2
	speed = Vector2(400, 400)

func _physics_process(delta):
	velocity = direction * speed * delta
	global_position += velocity
