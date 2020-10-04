extends Area2D
class_name Boss

var score : int
var damage : int
var health : int
onready var drop_coin = preload("res://scenes/pickup/Coin.tscn")
onready var explosion = preload("res://scenes/effect/Explosion.tscn")

# Inicialização
func _ready():
	score = 10
	damage = 1
	health = 20

# Função chamada quando um inimigo é elimidado.
# Também cria os cristais de acordo com o inimigo.
func destroy():
	SoundManager.play_sfx("MainExplosion")
	for i in score:
		Global.create_coin(drop_coin, global_position)
	Global.create_explosion(explosion, global_position, "puff", Vector2(2, 2))
	Global.set_boss_state(Global.DIED)
	if Global.add_level_index():
		get_tree().call_group("world", "transition_level", 4.0)
	else:
		Global.change_scene("res://scenes/interface/Victory.tscn")
	queue_free()

# Sinal recebido quando uma área (attack player) entra na área do inimigo.
func on_boss_area_entered(area):
	if area is Ammo and health > 0:
		health -= area.damage
		area.destroy()
	
		if health <= 0:
			Global.create_explosion(explosion, global_position, "puff", Vector2(2, 2))
			destroy()

