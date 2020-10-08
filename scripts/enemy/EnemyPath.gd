extends Path2D
class_name EnemyPath

export (float) var follow_speed setget set_follow_speed
export (int) var number_follows setget set_number_follows
export (float) var enemy_offset setget set_enemy_offset
export (bool) var follow_loop setget set_follow_loop
export (PackedScene) var enemy setget set_packedscene_enemy
export (float) var restart_time setget set_restart_time

var follows : Array

func _ready():
	create_follow()
	set_array_follows()
	set_follows_loop()
	create_enemies()
	set_offset_between_enemies()
	
	$Restart.set_wait_time(restart_time)
	$Restart.start()
	$Restart.set_paused(true)

func _physics_process(delta):
	for follow in follows:
		follow.offset += follow_speed * delta

func set_restart_time(value:float):
	restart_time = value
	
func create_follow():
	for i in range(number_follows):
		add_child(PathFollow2D.new())
		
func restart_follows():
	reset_follow_offset()
	set_offset_between_enemies()

func recreate_enemies():
	for follow in follows:
		if !follow.get_children().size():
			follow.add_child(enemy.instance())

func followers_finished():
	var finished = true
	for follow in follows:
		if follow.unit_offset != 1:
			finished = false
	return finished
		
func set_offset_between_enemies():
	for i in follows.size():
		follows[i].offset += enemy_offset * i
	
func set_array_follows():
	for child in get_children():
		if child is PathFollow2D:
			follows.append(child)

func reset_follow_offset():
	for follow in follows:
		follow.set_offset(0)
	
func set_follows_loop():
	for follow in follows:
		follow.set_loop(follow_loop)

func create_enemies():
	for follow in follows:
		follow.add_child(enemy.instance())

func set_follows_offset():
	for follow in follows:
		follow.set_offset(enemy_offset)
	
#===
func set_follow_loop(value:bool):
	follow_loop = value
	
func set_follow_speed(value:float):
	follow_speed = value
	
func set_number_follows(value:int):
	number_follows = value
	
func set_enemy_offset(value:float):
	enemy_offset = value

func set_packedscene_enemy(value:PackedScene):
	enemy = value

func on_restart_timeout():
	restart_follows()
	recreate_enemies()
	$Restart.set_paused(true)

func on_finished_timeout():
	if followers_finished():
		$Restart.set_paused(false)
	
