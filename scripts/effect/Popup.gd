# Cena que representa os poupups do itens
# coletados (Pickups)
extends Node2D

# Variáveis
var direction : Vector2
var velocity : Vector2
var speed : Vector2
var text : String setget set_text
var color : Color setget set_color

# Inicialização
func _ready():
	direction = Vector2.UP
	velocity = Vector2.ZERO
	speed = Vector2(50, 50)
	
	$Tween.interpolate_property(self, "modulate:a",
								1, 0, 1, 
								Tween.TRANS_LINEAR,
								Tween.EASE_OUT,0)
	$Tween.start()

# Movimento do popup
func _physics_process(delta):
	velocity = direction * speed * delta
	position += velocity

# Definir o texto do popup
func set_text(value : String):
	text = value
	$Label.text = "+%s"%value

# Definir a cor do texto do popup
func set_color(value : Color):
	color = value
	$Label.add_color_override("font_color", color)

# Destruir essa cena (instancia) quando a 
# interpolação for finalizada
func on_tween_all_completed():
	queue_free()
