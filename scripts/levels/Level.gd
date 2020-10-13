extends Node2D
class_name Level

var level
var difficulty
var skycolor
var hudcolor
var index

func _ready():
	#skycolor = $Background/SkyColor
	#skycolor.color = Color("#28a0ff")
	hudcolor = Global.game_data["Level"]["hudcolor"]
	index = Global.game_data["Level"]["index"]
	print("color: ",hudcolor[index])
	VisualServer.set_default_clear_color(Color(hudcolor[index]))
	SoundManager.fade_in_level_music()
	
func disable_player():
	if $ActorContainer.has_node("Player"):
		$ActorContainer/Player/Shape.set_deferred("disabled", true)

func stop_spawn_enemies():
	for spawn in $SpawnContainer.get_children():
		spawn.set_can_spawn(false)

func active_boss_attack():
	$BossPath/Follow.get_child(0).active_weapons()

func on_boss_timer_timeout():
	stop_spawn_enemies()
	active_boss_attack()
	$BossPath/APlayer.play("down")
