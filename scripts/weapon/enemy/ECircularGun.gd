extends Weapon
class_name ECircularGun

var can_shooting = false
var angle = 0
var time = 2

func _ready():
	get_barrels()
	$StartShoot.start()

func _physics_process(delta):
	if can_shooting:
		if Global.get_boss_state() == Global.FIGHTING:
			update_angle(delta)
			shoot()

func update_angle(delta):
	angle += 2 * PI * delta/time
	angle = wrapf(angle, -PI, PI)
	$Barrel.rotation = angle

func on_start_shoot_timeout():
	can_shooting = true
	$StopShoot.start()
	
func on_stop_shoot_timeout():
	can_shooting = false 
	$StartShoot.start()
