extends Ammo

# Enemy Bullet
func _ready():
	damage = 1
#	speed = Vector2(30, 30)

func _physics_process(delta):
	velocity = direction * speed * delta
	global_position += velocity
