extends Enemy
class_name CEnemy

func _ready():
	health = 20
	damage = 5
	score = 2
	
#var angle : float 
#var time : float
#var clockwise : bool
#var radius : Vector2
#var sposition : Vector2
#
#func _ready():
#	$ASprite.play("flying");
#
#	angle = 0
#	time = 2
#	health = 20
#	score = 2
#
#	randomize()
#	var rx = rand_range(10, 20)
#	var ry = rand_range(20, 40)
#	var sx = rand_range(20, 50)
#	var sy = rand_range(10, 30)
#
#	radius = Vector2(rx, ry)
#	speed = Vector2(sx, sy)
#	sposition = position
#	clockwise = Global.choose([true, false])
#
#func _physics_process(delta):
#	update_angle(delta);
#	position.x = (cos(angle) * radius.x) + sposition.x;
#	position.y = (sin(angle) * radius.y) + sposition.y;
#	sposition.y += direction.y * speed.y * delta;
#
#func update_angle(delta):
#	if clockwise:
#		angle += 2 * PI * delta/time;
#	else:
#		angle -= 2 * PI * delta/time;
#	angle = wrapf(angle, -PI, PI);
#
#
