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
	VisualServer.set_default_clear_color(Color(hudcolor[index]))
	SoundManager.fade_in_level_music()
	
	if has_node("Bosstime") && has_node("Warning/TWarning"):
		$Warning/TWarning.set_wait_time($Bosstime.get_wait_time()-5)
		$Warning/TWarning.start()
	
#	Global.game_data["Player"]["powerup"] = 3
#	Global.game_data["Player"]["super"] = 3
	
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

func on_twarning_timeout():
	$Warning/AWarning.play("down")
	
func on_awarning_animation_finished(anim_name):
	if $Warning:
		$Warning.queue_free()

func play_warning_sfx():
	SoundManager.play_sfx("BossWarning")

func stop_warning_sfx():
	SoundManager.stop_sfx("BossWarning")
	
func on_level_tree_exited():
	SoundManager.stop_all_sfx()
