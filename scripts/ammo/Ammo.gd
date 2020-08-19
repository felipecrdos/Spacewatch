# Classe base para munições contendo variáveis
# e funções comuns a todos os tipos de munições
# que herdam dessa classe.
extends Area2D
class_name Ammo

# Variáveis
var direction : Vector2 setget set_direction
var velocity : Vector2 setget set_velocity
var speed : Vector2 setget set_speed
var angle : float setget set_angle
var damage : float setget set_damage
var screen_width : float
var screen_height : float

# Inicialização
func _ready():
	screen_width = get_viewport_rect().size.x
	screen_height = get_viewport_rect().size.y

# Encapsulamento
func set_direction(value:Vector2):
	direction = value
	rotation = direction.angle()
	
func set_velocity(value:Vector2):
	velocity = value
	
func set_speed(value:Vector2):
	speed = value

func set_damage(value : float):
	damage = value

func set_angle(value:float):
	angle = value
	angle = wrapf(angle, -PI, PI)

# A função set_bounds define o limite onde
# a munição estará ativa. Munição é destruida
# ao ultrapassar os limites definidos.
func set_bounds():
	var out_screen = false
	if global_position.x < 0 || global_position.x > screen_width:
		out_screen = true
	elif global_position.y < 0 || global_position.y > screen_height:
		out_screen = true
	if out_screen:
		queue_free()

# Timer chamado a cada 0.1 para chamar a função set_bounds
func on_timer_timeout():
	set_bounds()
