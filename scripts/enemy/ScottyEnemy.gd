extends Enemy

var angle : float 
var time : float
var clockwise : bool
var radius : Vector2;
var sposition : Vector2;

func _ready():
	$ASprite.play("flying");
	
	angle = 0
	time = 2
	health = 20
	crystals = 2
	radius = Vector2(30, 40)
	speed = Vector2(100, 40)
	sposition = position
	clockwise = Global.choose([true, false])
	
func _physics_process(delta):
	update_angle(delta);
	position.x = (cos(angle) * radius.x) + sposition.x;
	position.y = (sin(angle) * radius.y) + sposition.y;
	sposition.y += direction.y * speed.y * delta;
	
func update_angle(delta):
	if clockwise:
		angle += 2 * PI * delta/time;
	else:
		angle -= 2 * PI * delta/time;
	angle = wrapf(angle, -PI, PI);
	
	
