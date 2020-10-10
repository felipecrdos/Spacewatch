extends Weapon
class_name DGun

var left_barrel
var right_barrel

var angle : float
var radius : float

var left_barrel_spos : Vector2
var rigth_barrel_spos : Vector2
var time  : float

func _ready():
	left_barrel = $LeftBarrel
	right_barrel = $RightBarrel
	
	left_barrel_spos = left_barrel.position
	rigth_barrel_spos = right_barrel.position
	
	angle = 0
	radius = 50
	time = 1
	
func _physics_process(delta):
	update_angle(delta)
	
	left_barrel.position.x = (cos(angle) * radius) + left_barrel_spos.x
	right_barrel.position.x = (cos(angle-PI ) * radius) + rigth_barrel_spos.x
	
	
func update_angle(delta):
	angle += 2 * PI * delta/time
	angle = wrapf(angle, -2*PI, 2*PI)
