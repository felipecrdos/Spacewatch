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

onready var explosion = preload("res://scenes/effect/Explosion.tscn");

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
	speed	 = Vector2(100, 100)
	screen_size = get_viewport_rect().size
	
	Global.player = self
	player_data = Global.game_data["Player"]
	level_data = Global.game_data["Level"]
	
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

	if Input.is_key_pressed(KEY_1):
		SoundManager.play_sfx("SelectButton")
		
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
	
func update_weapon():
	for weapon in weapons:
		weapon.visible = false
	weapons[player_data["powerup"]].visible = true

func idle_state(delta):
	$ASprite.play("vertical")
	
func flying_state(delta):
	if direction.x != 0:
		$ASprite.play("horizontal")
		$ASprite.flip_h = true if direction.x > 0 else false
	else:
		$ASprite.play("vertical")
	
func invulnerable_state(delta):
	$ASprite.play("vertical")
	state = State.FLYING
	
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
	area.destroy()
	set_flash_effect(true)
	$TShader.start()

		
func set_flash_effect(value : bool):
	$ASprite.material.set_shader_param("flashing", value)
	
func on_tshader_timeout():
	set_flash_effect(false)
