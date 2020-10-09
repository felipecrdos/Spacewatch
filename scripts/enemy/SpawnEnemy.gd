extends Position2D
class_name SpawnEnemy

var screen_width	: float
var screen_height	: float
var can_spawn		: bool setget set_can_spawn, get_can_spawn

func _ready():
	screen_width = get_viewport_rect().size.x
	screen_height = get_viewport_rect().size.y
	can_spawn = true

func set_enemy_path_loop(value:bool):
	for child in get_children():
		if child is Path2D:
			child.set_follow_loop(value)
	
func set_can_spawn(value:bool):
	can_spawn = value
	set_enemy_path_loop(value)

func get_can_spawn():
	return can_spawn
