extends Area2D
class_name Boss

var score : int
var damage : int
var health : int
var max_health : int
var is_damaged : bool
onready var drop_coin = preload("res://scenes/pickup/Coin.tscn")
onready var explosion = preload("res://scenes/effect/Explosion.tscn")

# Inicialização
func _ready():
	score = 10
	damage = 1
	health = 20
	max_health = health
	is_damaged = false

# Função chamada quando um inimigo é elimidado.
# Também cria os cristais de acordo com o inimigo.
func destroy():
	SoundManager.play_sfx("MainExplosion")
	for i in score:
		Global.create_pickup(drop_coin, global_position)
	
	Global.create_explosion(explosion, global_position, "fire", Vector2(3, 3), 5)
	Global.create_explosion(explosion, global_position+Vector2(0, 30), "fire", Vector2(2, 2), 8)
	Global.create_explosion(explosion, global_position+Vector2(30, 0), "fire", Vector2(1, 1), 10)
	Global.create_explosion(explosion, global_position+Vector2(-30, 0), "fire", Vector2(1, 1), 10)
	
	get_tree().call_group("world", "boss_was_killed")
#	if Global.add_level_index():
#		get_tree().call_group("world", "transition_level", 4.0)
#	else:
#		Global.change_scene("res://scenes/interface/Victory.tscn")
	queue_free()

# Sinal recebido quando uma área (attack player) entra na área do inimigo.
func on_boss_area_entered(area):
	if area is Ammo and health > 0:
		health -= area.damage
		area.destroy()
		
		if !is_damaged && health <= max_health/2:
			emit_smoke(true)
			
		if health <= 0:
			destroy()
		else:
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
