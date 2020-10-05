extends Node2D
class_name Level

var level
var difficulty
var boss
var skycolor

func _ready():
	skycolor = $Background/SkyColor
	skycolor.color = Color("#28a0ff")
	VisualServer.set_default_clear_color(Color("#0089ff"))
	
func disable_player():
	if $ActorContainer.has_node("Player"):
		$ActorContainer/Player/Shape.set_deferred("disabled", true)

func wakeup_boss(time : float):
	$Timer.set_wait_time(time)
	$Timer.start()
	
func on_timer_timeout():
	stop_spawn_enemies()
	active_boss_attack()
	$BossPath/APlayer.play("down")
	
func stop_spawn_enemies():
	for spawn in $SpawnContainer.get_children():
		spawn.set_deferred("can_spawn", false)

func active_boss_attack():
	$BossPath/Follow.get_child(0).active_weapons()
	
