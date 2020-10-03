# Cena base para todos os inimigos em comum
extends Area2D
class_name Enemy

# Variáveis
var velocity : Vector2
var direction : Vector2
var speed : Vector2
var crystals : int
var damage : int
var health : int
onready var explosion = preload("res://scenes/effect/Explosion.tscn")
onready var drop_crystal = preload("res://scenes/pickup/Crystal.tscn")
onready var drop_powerup = preload("res://scenes/pickup/Powerup.tscn")
onready var drop_health = preload("res://scenes/pickup/Health.tscn")
# Inicialização
func _ready():
	velocity = Vector2.ZERO
	direction = Vector2.DOWN
	speed = Vector2(100, 100)
	crystals = 0
	damage = 1
	health = 20

# Função chamada quando um inimigo é elimidado.
# Também cria os cristais de acordo com o inimigo.
func destroy():
	Global.findnode("MCamera").shake(2, 5)
	SoundManager.play_sfx("EnemyExplosion")
	if(Global.choose(range(100)) <= 3):
		Global.create_powerup(drop_powerup, position)
	
	if(Global.choose(range(100)) <= 3):
		Global.create_powerup(drop_health, position)
		
	for i in crystals:
		Global.create_crystal(drop_crystal, position)
	Global.create_explosion(explosion, position, "fire", Vector2(2, 2))
	queue_free()

# Sinal recebido quando uma área (attack player) entra na área do inimigo.
func on_enemy_area_entered(area):
	if area is Ammo:
		health -= area.damage
		area.destroy()
	
		if health <= 0:
			Global.create_explosion(explosion, position, "puff", Vector2(2, 2))
			destroy()

