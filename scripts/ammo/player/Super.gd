extends Area2D
class_name SuperAttack

var damage : float
var speed : Vector2
var direction : Vector2
var velocity : Vector2
var superhit : PackedScene

func _ready():
	damage = 20
	speed = Vector2(60, 60)
	direction = Vector2.UP
	superhit = load("res://scenes/effect/SuperHit.tscn")
	
func _physics_process(delta):
	velocity = direction * speed * delta
	global_position += velocity

func set_animation(name:String):
	$ASprite.play(name)

func on_super_animation_finished(anim_name):
	queue_free()

func play_super_spawn():
	SoundManager.play_sfx("super_loading")
	
func play_super_explosion():
	SoundManager.play_sfx("super_explosion")
	
func on_super_area_entered(area):
	SoundManager.play_sfx("BulletHit")
	Global.create_hit(superhit, area.global_position+Vector2(rand_range(-10, 10), rand_range(-10, 10)))
	 
func on_stop_timeout():
	velocity = Vector2.ZERO
	direction = Vector2.ZERO
	speed = Vector2.ZERO
