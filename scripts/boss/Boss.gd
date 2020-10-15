extends Area2D
class_name Boss

var score : int
var damage : int
var health : int
var max_health : int
var is_damaged : bool
var is_alive   : bool
var texture_size : Vector2
onready var coin = preload("res://scenes/pickup/CoinPickup.tscn")
onready var explosion = preload("res://scenes/effect/Explosion.tscn")

# Inicialização
func _ready():
	add_to_group("enemy")
	score = 10
	damage = 1
	health = 500
	max_health = health
	is_damaged = false
	is_alive = true
	
	texture_size = $ASprite.get_sprite_frames().get_frame("default", 0).get_size()

func _process(delta):
	if Global.is_on_screen(global_position, texture_size):
		SoundManager.play_sfx("BossEngine")
		set_process(false)
	
func destroy():
	SoundManager.play_sfx("MainExplosion")
	for i in score:
		Global.create_pickup(coin, global_position)
	
	Global.create_explosion(explosion, global_position, "fire", Vector2(3, 3), 5)
	Global.create_explosion(explosion, global_position+Vector2(0, 30), "fire", Vector2(2, 2), 8)
	Global.create_explosion(explosion, global_position+Vector2(30, 0), "fire", Vector2(1, 1), 10)
	Global.create_explosion(explosion, global_position+Vector2(-30, 0), "fire", Vector2(1, 1), 10)
	
	get_tree().call_group("world", "boss_was_killed")
	queue_free()

# Sinal recebido quando uma área (attack player) entra na área do inimigo.
func on_boss_area_entered(area):
	if Global.is_on_screen(global_position, texture_size):
		if area is Ammo || area is SuperAttack:
			health -= area.damage
			if is_alive && health <= 0:
				is_alive = false
				destroy()
	
			if !is_damaged && health <= max_health/2:
				emit_smoke(true)
	
			set_flash_effect(true)
			$Timer.start()
			
			
func emit_smoke(value:bool):
	is_damaged = true
	for particle in $Smoke.get_children():
		particle.set_emitting(true)
		
func set_flash_effect(value : bool):
	$ASprite.material.set_shader_param("flashing", value)
	
func on_timer_timeout():
	set_flash_effect(false)

func active_weapons():
	for weapon in $Weapons.get_children():
		weapon.set_deferred("active", true)
