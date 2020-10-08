# Classe responsável por spawnar inimigo Scotty
extends Position2D

# Variáveis
export (PackedScene) var enemy

var can_spawn		: bool
var screen_width	: float
var screen_height	: float
var offset			: Vector2

# Inicializar
func _ready():
	screen_width = get_viewport_rect().size.x
	screen_height = get_viewport_rect().size.y
	position.x = screen_width/2
	position.y = -screen_height/2
	
	offset = Vector2(10, 0)
	can_spawn = true
	
# A Função spawn_enemy é chamada quando 
# um sinal de timeout é disparada.
func spawn_enemy():
	offset.x = Global.choose([40, 80])
	offset.x *= Global.choose([1, -1])
	var px = position.x + offset.x
	var py = position.y
	var new = enemy.instance()
	new.set_deferred("position", Vector2(px, py))
	Global.findnode("ActorContainer").call_deferred("add_child", new)

func on_timer_timeout():
	if can_spawn:
		spawn_enemy()
	
func set_can_spawn(value:bool):
	can_spawn = value

func get_can_spawn():
	return can_spawn

