extends Ammo
class_name Rocket

var target : Area2D
var start_direction : Vector2

func _ready():
	damage = 10
	angle = direction.angle()
	start_direction = direction
	speed = Vector2(200, 200)
	
	
func _physics_process(delta):
	follow_target()
	velocity = direction * speed * delta
	global_position += velocity

func follow_target():
	if target:
		var target_direction = global_position.direction_to(target.global_position)
		var target_angle = target_direction.angle()
		angle = lerp(angle, target_angle, 0.1)
		direction = Vector2(cos(angle), sin(angle))
		rotation = angle
	else:
		find_target()
		

func find_target():
	var enemies = get_tree().get_nodes_in_group("enemy")
	var has_enemy = enemies.size() > 0 
	
	if has_enemy:
		var first_position = enemies[0].global_position
		var min_distance = global_position.distance_to(first_position)
		
		for enemy in enemies:
			var target_distance = global_position.distance_to(enemy.global_position) 
			if target_distance <= min_distance:
				min_distance = target_distance 
				target = enemy

func set_animation(name:String):
	$ASprite.play(name)
	
func on_rocket_area_entered(area):
	destroy()
