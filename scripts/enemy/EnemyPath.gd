extends Path2D
class_name EnemyPath

export (float) var follow_speed setget set_follow_speed
export (int) var number_follows setget set_number_follows
export (float) var enemy_offset setget set_enemy_offset
export (PackedScene) var enemy setget set_packedscene_enemy
export (float) var restart_time setget set_restart_time
export (float) var start_delay setget set_start_delay
export (bool) var follow_loop setget set_follow_loop
export (bool) var follow_rotate setget set_follow_rotate

var follows : Array
var ready = false

func _ready():
	create_follow()
	set_array_follows()
	set_follows_loop()
	set_follows_rotate()
	create_enemies()
	set_offset_between_enemies()
	
	$Delay.set_wait_time(start_delay)
	$Delay.start()

func _physics_process(delta):
	followers_finished()
	if ready:
		for follow in follows:
			follow.offset += follow_speed * delta
	
func create_follow():
	for i in range(number_follows):
		add_child(PathFollow2D.new())
		
func restart_follows():
	reset_follow_offset()
	set_offset_between_enemies()
	
func recreate_enemies():
	for follow in follows:
		if !follow.get_children().size():
			if enemy:
				follow.add_child(enemy.instance())

func followers_finished():
	for follow in follows:
		if follow.unit_offset != 1.0:
			return false
	return true
	
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

func set_follow_rotate(value:bool):
	follow_rotate = value

func set_follows_rotate():
	for follow in follows:
		follow.set_rotate(follow_rotate)

func create_enemies():
	for follow in follows:
		if enemy:
			follow.add_child(enemy.instance())

func set_follows_offset():
	for follow in follows:
		follow.set_offset(enemy_offset)

func destroy_all_enemies():
	for follow in follows:
		for child in follow.get_children():
			if child is Enemy:
				child.destroy()
#===

func set_restart_time(value:float):
	restart_time = value

func set_start_delay(value:float):
	start_delay = value
	
func set_follow_loop(value:bool):
	follow_loop = value

func set_follows_loop(value:bool=false):
	for follow in follows:
		follow.set_loop(value)
	
func get_follow_loop():
	return follow_loop
	
func set_follow_speed(value:float):
	follow_speed = value
	
func set_number_follows(value:int):
	number_follows = value
	
func set_enemy_offset(value:float):
	enemy_offset = value

func set_packedscene_enemy(value:PackedScene):
	enemy = value

func set_ready(value:bool):
	ready = value

func on_finished_timeout():
	
	if followers_finished():
		set_ready(false)
		$Finished.stop()
		
		if get_follow_loop():
			restart_follows()
			recreate_enemies()
			$Delay.set_wait_time(restart_time)
			$Delay.start()
			$Finished.start()
			
			

func on_delay_timeout():
	if !ready:
		set_ready(true)
