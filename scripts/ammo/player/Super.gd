extends Area2D
class_name SuperAttack

var damage : float
var speed : Vector2
var direction : Vector2
var velocity : Vector2

func _ready():
	damage = 50
	speed = Vector2(400, 400)
	SoundManager.play_sfx("PlayerShoot")
	
func _physics_process(delta):
	velocity = direction * speed * delta
	global_position += velocity

func set_animation(name:String):
	$ASprite.play(name)


func on_super_animation_finished(anim_name):
	queue_free()
