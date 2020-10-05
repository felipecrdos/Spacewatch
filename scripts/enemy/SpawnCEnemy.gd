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
	offset = Vector2(10, 0)
	
# A Função spawn_enemy é chamada quando 
# um sinal de timeout é disparada.
func spawn_enemy():
	var px = position.x + (offset.x * Global.choose([1, -1]))
	var py = position.y
	var new = enemy.instance()
	new.set_deferred("position", Vector2(px, py))
	Global.findnode("ActorContainer").call_deferred("add_child", new)

func on_timer_timeout():
	#if Global.get_boss_state() == Global.WAITING:
	if can_spawn:
		spawn_enemy()
