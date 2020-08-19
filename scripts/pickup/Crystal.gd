# Cena cristal que representa o score do player.
# Herda da cena Pickup.
extends Pickup
class_name Crystal

# Variáveis
var target : Vector2

# Inicialização
func _ready():
	var tx = rand_range(position.x, position.x + 200)
	var ty = rand_range(position.y - 40, position.y - 80)
	target = Vector2(tx, ty)
	speed = Vector2(10, 10)
	value = "5"

# Movimentação
func _physics_process(delta):
	direction = target - position
	direction *= delta
	position += direction

# Sinal recebido quando um body colide com o cristal
func on_pickup_body_entered(body):
	get_tree().call_group("world", "update_crystal", 5)
	destroy()

# Função chamada para destruir o cristal ao ser coletada.
# É criado um popup com o valor do cristal. Também é
# criado particulas para efeito de coleta do cristal.
func destroy():
	Global.create_popup(popup, position, value, Color.chartreuse)
	Global.create_particle(particle, position, Color.chartreuse)
	queue_free()

# Sinal recebido para que o cristal vá de encontro ao player
func on_timer_timeout():
	if Global.player:
		target = Global.player.position
		$Timer.wait_time = 0.1
