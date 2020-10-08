extends Position2D
class_name Barrel

var sfirerate : float
export (bool) var flash_on
export (PackedScene) var ammo
export (float) var firerate setget set_firerate
export (Vector2) var speed_ammo setget set_speed_ammo
export (SpriteFrames) var barrel_sprite setget set_barrel_sprite
export (String, "rectA_blue", "rectA_green", "rectA_yellow", 
				"rectA_purple", "rectA_pink", "rectA_red",
				"roundA_blue", "roundA_green", "roundA_yellow", 
				"roundA_purple", "roundA_pink", "roundA_red"
				) var ammo_animation = "rectA_blue"

func _ready():
	$Flash.set_animation(ammo_animation)

func set_firerate(value : float):
	firerate = value
	sfirerate = firerate
	
func set_speed_ammo(value : Vector2):
	speed_ammo = value

func play_flash():
	if !$Flash.is_playing() && flash_on:
		$Flash.play()
		
func shoot():
	firerate -= 1
	if firerate <= 0:
		play_flash()
		
		var new = ammo.instance()
		new.set_deferred("global_position", global_position)
		new.set_deferred("speed", speed_ammo)
		new.set_deferred("direction", Vector2(cos(rotation),sin(rotation)))
		new.set_animation(ammo_animation)
		Global.findnode("AmmoContainer").call_deferred("add_child", new)
		firerate = sfirerate

func on_flash_animation_finished():
	$Flash.stop()
	$Flash.set_frame(0)
	
func set_barrel_sprite(value:SpriteFrames):
	$ASprite.set_visible(true)
	$ASprite.set_sprite_frames(value)
	
