# Cena base para todos os inimigos em comum
extends Area2D
class_name Enemy

# Variáveis
var velocity : Vector2
var direction : Vector2
var speed : Vector2
var score : int
var damage : int
var health : int
var is_hit : bool
var screen_width : float
var screen_height : float

enum {COIN, HEALTH, SHIELD, POWERUP, SUPER}
onready var explosion = preload("res://scenes/effect/Explosion.tscn")
onready var coin = preload("res://scenes/pickup/Coin.tscn")
onready var pickups = [	preload("res://scenes/pickup/Coin.tscn"),
						preload("res://scenes/pickup/Health.tscn"),
						preload("res://scenes/pickup/Shield.tscn"),
						preload("res://scenes/pickup/Powerup.tscn"),
						preload("res://scenes/pickup/Super.tscn")]

# Inicialização
func _ready():
	velocity = Vector2.ZERO
	direction = Vector2.DOWN
	speed = Vector2(100, 100)
	score = 0
	damage = 1
	health = 20
	
	screen_width = get_viewport_rect().size.x
	screen_height = get_viewport_rect().size.y

# Função chamada quando um inimigo é elimidado.
# Também cria os cristais de acordo com o inimigo.
func destroy():
	Global.findnode("MCamera").shake(2, 5)
	SoundManager.play_sfx("EnemyExplosion")
	
	randomize()
	var chance = randi() % 100 + 1 # 1 a 100
	if(chance%5 == 0): # 20% chance de dropar algum pickup
		# Ao dropar o pickup
			# 33.33% chance HEALTH
			# 33.33% chance SHIELD
			# 22.22% chance POWERUP
			# 11.11% chance SUPER
		var chosen = Global.choose([HEALTH, SHIELD, POWERUP, SUPER, 
									HEALTH, SHIELD, POWERUP, 
									HEALTH, SHIELD])
		Global.create_pickup(pickups[chosen], position)
		
	for i in score:
		Global.create_pickup(pickups[COIN], position)
	queue_free()

# Sinal recebido quando uma área (attack player) entra na área do inimigo.
func on_enemy_area_entered(area):
	if area is Ammo:
		health -= area.damage
		area.destroy()
	
		if health <= 0:
			Global.create_explosion(explosion, position, "fire", Vector2(2, 2))
			destroy()
		else:
			set_flash_effect(true)
			$Flash.start()
			
func set_flash_effect(value : bool):
	$ASprite.material.set_shader_param("flashing", value)

func on_flash_timeout():
	set_flash_effect(false)
	
func set_limit():
	if global_position.y > screen_height:
		queue_free()

func on_outscreen_timeout():
	set_limit()
