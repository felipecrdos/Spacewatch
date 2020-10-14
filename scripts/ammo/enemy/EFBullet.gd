extends Ammo
class_name EFBullet

func _ready():
	damage = 5
#	speed = Vector2(30, 30)

func _physics_process(delta):
	velocity = direction * speed * delta
	global_position += velocity

func set_animation(name:String):
	$ASprite.play(name)

func on_ebullet_area_entered(area):
	destroy()
