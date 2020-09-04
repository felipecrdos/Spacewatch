extends Area2D
class_name Boss

var crystals : int
var damage : int
var health : int
onready var crystal = preload("res://scenes/pickup/Crystal.tscn")
onready var explosion = preload("res://scenes/effect/Explosion.tscn")

# Inicialização
func _ready():
	crystals = 10
	damage = 1
	health = 20

# Função chamada quando um inimigo é elimidado.
# Também cria os cristais de acordo com o inimigo.
func destroy():
	for i in crystals:
		Global.create_crystal(crystal, global_position)
	Global.create_explosion(explosion, global_position, "puff", Vector2(2, 2))
	queue_free()

# Sinal recebido quando uma área (attack player) entra na área do inimigo.
func on_boss_area_entered(area):
	if area is Ammo:
		health -= area.damage
		area.queue_free()
	
		if health <= 0:
			Global.create_explosion(explosion, global_position, "puff", Vector2(2, 2))
			destroy()
