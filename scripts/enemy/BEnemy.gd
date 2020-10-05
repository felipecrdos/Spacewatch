extends Enemy
class_name BEnemy

var time : float
var clockwise : bool
var angle : Vector2 
var radius : Vector2
var sposition : Vector2

func _ready():
	$ASprite.play("flying")
	
	randomize()
	var rx = rand_range(10, 50)
	var ry = rand_range(10, 50)
	
	radius = Vector2(rx, ry)
	speed = Vector2(100, 30)
	angle = Vector2(0, 90)
	sposition = position
	score = 1
	health = 15
	time = 2
	clockwise = Global.choose([true, false])

func _physics_process(delta):
	update_angle(delta);
	position.x = (cos(angle.x) * radius.x) + sposition.x;
	position.y = (sin(angle.y) * radius.y) + sposition.y;
	sposition.y += direction.y * speed.y * delta;
	
func update_angle(delta):
	if clockwise:
		angle.x += 2 * PI * delta/time;
	else:
		angle.x -= 2 * PI * delta/time;
	angle.x = wrapf(angle.x, -PI, PI);
	
	

