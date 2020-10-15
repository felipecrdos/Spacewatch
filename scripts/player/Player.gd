extends KinematicBody2D
class_name Player

enum State {IDLE, FLYING, INVULNERABLE, DYING}
enum Func {INPUT, HMOVE, VMOVE, MOVE}

var funcs_names	: Array
var funcs_refs 	: Array
var funcs_mask 	: Dictionary
var weapons		: Array
var state

var velocity 	: Vector2
var direction   : Vector2
var speed    	: Vector2
var screen_size : Vector2
var player_data	: Dictionary
var level_data	: Dictionary

onready var explosion 	= preload("res://scenes/effect/Explosion.tscn");
onready var shield		= preload("res://scenes/player/PlayerShield.tscn")
onready var super 		= preload("res://scenes/ammo/player/Super.tscn")
func _ready():
	funcs_names = [	"idle_state", "flying_state", 
					"invulnerable_state", "dying_state"]
					
	funcs_mask = {	State.IDLE:				[false, false, false, false],
					State.FLYING:			[true, true, true, true],
					State.INVULNERABLE:		[true, true, true, true], 
					State.DYING:			[false, true, true, true]}
					
	for n in funcs_names:
		funcs_refs.append(funcref(self, n))

	
	state = State.FLYING
	velocity = Vector2.ZERO
	direction= Vector2.ZERO
	speed	 = Vector2(150, 150)
	screen_size = get_viewport_rect().size
	position.x = screen_size.x/2
	position.y = screen_size.y/2
	
	Global.player = self
	player_data = Global.game_data["Player"]
	level_data = Global.game_data["Level"]
	
	if player_data["shieldup"]:
		remain_shield()
		
	weapons = $Weapon.get_children()
	update_weapon()

func _physics_process(delta):
	if funcs_mask[state][Func.INPUT]:
		input()
	if funcs_mask[state][Func.HMOVE]:
		hmove()
	if funcs_mask[state][Func.VMOVE]:
		vmove()
	if funcs_mask[state][Func.MOVE]:
		move()
	funcs_refs[state].call_func(delta)
	set_limits()
	
func input():
	direction = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		direction.x = 1
	if Input.is_action_pressed("ui_left"):
		direction.x = -1
	if Input.is_action_pressed("ui_down"):
		direction.y = 1
	if Input.is_action_pressed("ui_up"):
		direction.y = -1
	if Input.is_action_pressed("ui_accept"):
		weapons[player_data["powerup"]].shoot()
	if Input.is_action_just_pressed("ui_shield"):
		create_shield()
		
	if Input.is_action_just_pressed("ui_super"):
		if player_data["super"] > 0:
			create_super()

	if direction != Vector2.ZERO:
		direction = direction.normalized()

func hmove():
	velocity.x = direction.x * speed.x
func vmove():
	velocity.y = direction.y * speed.y
func move():
	velocity = move_and_slide(velocity, Vector2.UP)
func set_limits():
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func update_health():
	if player_data["health"] > 0:
		state = State.INVULNERABLE
	elif player_data["health"] <= 0:
		state = State.DYING

func update_shield():
	pass

func create_shield():
	if !has_active_shield() && has_shield():
		add_child(shield.instance())
		get_tree().call_group("world", "update_shield", -1)

func remain_shield():
	add_child(shield.instance())

func create_super():
	var new = super.instance()
	Global.findnode("AmmoContainer").call_deferred("add_child", new)
	new.set_deferred("global_position", global_position)
	get_tree().call_group("world", "update_super", -1)
	
	
func has_active_shield():
	return has_node("PlayerShield")

func has_shield():
	return player_data["shield"] > 0
	
func update_weapon():
	for weapon in weapons:
		weapon.visible = false
	weapons[player_data["powerup"]].visible = true

func set_animation():
	if direction.x > 0:
		$ASprite.play("right")
	elif direction.x < 0:
		$ASprite.play("left")
	else:
		$ASprite.play("default")
	
func idle_state(delta):
	$ASprite.play("default")
	
func flying_state(delta):
	set_animation()
	
func invulnerable_state(delta):
	if !$Blink.is_playing():
		$Blink.play("blink")
	set_animation()
	
func dying_state(delta):
	SoundManager.play_sfx("MainExplosion")
	SoundManager.fade_out_music(level_data["name"][level_data["index"]])
	Global.create_explosion(explosion, position, "fire", Vector2(2.0, 2.0))
	set_deferred("visible", false)
	Global.change_scene("res://scenes/interface/GameOver.tscn")
	queue_free()
	
# Sinal disparado quando qualquer tipo de inimigo atinge o player
func on_area_entered(area):
	SoundManager.play_sfx("PlayerHurt")
	get_tree().call_group("world", "update_health", -area.damage, self)
	Global.findnode("MCamera").shake(5, 30)
	set_flash_effect(true)
	$TShader.start()
	
	if area is Enemy:
		area.destroy()
		
func set_flash_effect(value : bool):
	$ASprite.material.set_shader_param("flashing", value)
	
func on_tshader_timeout():
	set_flash_effect(false)
	
func on_blink_animation_finished(anim_name):
	state = State.FLYING 
