extends Weapon
class_name ERadiusGun

var can_shooting = false

func _ready():
	get_barrels()
	$StartShoot.start()

func _physics_process(delta):
	if can_shooting:
		shoot()

func rotation_barrels():
	for barrel in barrels:
		barrel.rotation += PI/12 # += 45

	
func on_start_shoot_timeout():
	can_shooting = true
	$StopShoot.start()
	rotation_barrels()
	
func on_stop_shoot_timeout():
	can_shooting = false
	$StartShoot.start()
	
