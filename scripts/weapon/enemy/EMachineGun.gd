extends Weapon
class_name EMachineGun

var can_shooting = false
var active = false

func _ready():
	get_barrels()
	$StartShoot.start()

func _physics_process(delta):
	if active && can_shooting:
		shoot()
		
func on_start_shoot_timeout():
	can_shooting = true
	$StopShoot.start()

func on_stop_shoot_timeout():
	can_shooting = false
	$StartShoot.start()
