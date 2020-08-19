# Classe responsável por spawnar inimigo Blankey
extends Position2D

# Variáveis
export (PackedScene) var enemy
var screen_width
var screen_height

var velocity 	: Vector2
var speed 		: Vector2
var direction 	: Vector2
var offset		: Vector2

# Inicializar
func _ready():
	screen_width = get_viewport_rect().size.x
	screen_height = get_viewport_rect().size.y
	
	velocity = Vector2.ZERO
	direction = Vector2.RIGHT
	speed = Vector2(100, 100)
	offset = Vector2(20, 20)

# Game Loop (movimentar)
func _physics_process(delta):
	velocity = direction * speed * delta
	position += velocity
	set_bounds()

# Definir os limites da cena spawner 
# ao se movimentar pela tela
func set_bounds():
	var on_bound = false
	if position.x <= 0:
		direction.x = 1
		on_bound = true
	elif position.x >= screen_width:
		direction.x = -1
		on_bound = true
	if on_bound:
		spawn_enemy()

# A Função spawn_enemy é chamada quando a scene
# spawner tocar os limites da tela
func spawn_enemy():
	for i in range(4):
		var px = position.x + (i * (direction.x * offset.x))
		var py = position.y + (i * (direction.y + offset.y * -1))
		var new = enemy.instance()
		Global.findnode("ActorContainer").call_deferred("add_child", new)
		new.set_deferred("position", Vector2(px, py))
