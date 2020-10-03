extends Ammo
class_name Bullet

# Enemy Bullet
func _ready():
	damage = 2
	speed = Vector2(400, 400)
	SoundManager.play_sfx("PlayerShoot")
	
func _physics_process(delta):
	velocity = direction * speed * delta
	global_position += velocity

func set_animation(name:String):
	$ASprite.play(name)
