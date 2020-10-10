# Cena coin que representa o score do player.
# Herda da cena Pickup.
extends Pickup
class_name CoinPickup

# Variáveis
var target : Vector2
export (Texture) var particle_texture

# Inicialização
func _ready():
	var tx = rand_range(position.x, position.x + 200)
	var ty = rand_range(position.y - 40, position.y - 80)
	target = Vector2(tx, ty)
	speed = Vector2(2, 2)
	value = "1"

# Movimentação
func _physics_process(delta):
	direction = position.direction_to(target)
	position += direction * speed
	
# Sinal recebido quando um body colide com a moeda
func on_pickup_body_entered(body):
	SoundManager.play_sfx("CoinPickup")
	get_tree().call_group("world", "update_score", int(value))
	destroy()

# Função chamada para destruir a moeda ao ser coletada.
# É criado um popup com o valor da moeda. Também é
# criado particulas para efeito de coleta da moeda.
func destroy():
	Global.create_popup(popup, position, value, Color.goldenrod, Color.bisque)
	Global.create_particle(particle, position, particle_texture)
	queue_free()

# Sinal recebido para que a moeda vá de encontro ao player
func on_timer_timeout():
	if Global.player:
		target = Global.player.position
		$Timer.wait_time = 0.1
