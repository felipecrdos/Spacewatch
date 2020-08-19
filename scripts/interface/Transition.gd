# Cena que representa a transição de telas
extends Node2D

# Variáveis
onready var fade = $Fade
onready var tween = $Tween

# Função chamada externamente para fazer a 
# transição de telas.
func start(svalue, evalue, time, delay):
	tween.interpolate_property(fade, 
								"modulate:a",
								svalue, 
								evalue,
								time,
								Tween.TRANS_LINEAR,
								Tween.EASE_IN, 
								delay)
	tween.start()
