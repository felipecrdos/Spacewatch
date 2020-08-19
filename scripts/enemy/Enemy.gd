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
onready var crystal = preload("res://scenes/pickup/Crystal.tscn")
onready var explosion = preload("res://scenes/effect/Explosion.tscn")

# Inicialização
func _ready():
	velocity = Vector2.ZERO
	direction = Vector2.DOWN
	speed = Vector2(100, 100)
	crystals = 0
	damage = 1
	health = 5

# Função chamada quando um inimigo é elimidado.
# Também cria os cristais de acordo com o inimigo.
func destroy():
	for i in crystals:
		Global.create_crystal(crystal, position)
	queue_free()

# Sinal recebido quando um body (KinematicBody, RigidBody, StaticBody)
# entra na área do inimigo.
func on_enemy_body_entered(body):
	Global.create_explosion(explosion, position, "puff", Vector2(2, 2))
	get_tree().call_group("world","update_health",-damage, body)
	destroy()

# Sinal recebido quando uma área (attack player) entra na área do inimigo.
func on_enemy_area_entered(area):
	health -= area.damage
	if health <= 0:
		Global.create_explosion(explosion, position, "puff", Vector2(2, 2))
		destroy()

