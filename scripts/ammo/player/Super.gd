extends Ammo

func _ready():
	damage = 10
	speed = Vector2(400, 400)
	SoundManager.play_sfx("PlayerShoot")
	
func _physics_process(delta):
	velocity = direction * speed * delta
	global_position += velocity

func set_animation(name:String):
	$ASprite.play(name)
