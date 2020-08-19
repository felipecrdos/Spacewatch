extends KinematicBody2D
class_name Player

enum State {IDLE, FLY, HURT, DIE}
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

func _ready():
	funcs_names = [	"idle_state", "fly_state", 
					"hurt_state", "die_state"]
					
	funcs_mask = {	State.IDLE:	[false, false, false, false],
					State.FLY:	[true, true, true, true],
					State.HURT:	[true, true, true, true], 
					State.DIE:	[true, true, true, true]}
					
	for n in funcs_names:
		funcs_refs.append(funcref(self, n))
		
	state = State.FLY
	velocity = Vector2.ZERO
	direction= Vector2.ZERO
	speed	 = Vector2(100, 100)
	screen_size = get_viewport_rect().size
	
	Global.player = self
	player_data = Global.game_data["Player"]
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
		Global.findnode("MCamera").shake(10, 60)
		
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
		state = State.HURT
	elif player_data["health"] <= 0:
		state = State.DIE
	
func update_weapon():
	for weapon in weapons:
		weapon.visible = false
	weapons[player_data["powerup"]].visible = true

func idle_state(delta):
	$ASprite.play("idle")
	
func fly_state(delta):
	$ASprite.play("fly")
	
func hurt_state(delta):
	$ASprite.play("hurt")
	
func die_state(delta):
	$ASprite.play("die")
	yield($ASprite, "animation_finished")
	queue_free()
	
func on_timer_timeout():
	pass
