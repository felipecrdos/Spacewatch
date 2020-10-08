extends Position2D

var can_spawn		: bool
var screen_width	: float
var screen_height	: float

func _ready():
	screen_width = get_viewport_rect().size.x
	screen_height = get_viewport_rect().size.y
	can_spawn = true

func state_enemy_path(value:bool):
	for child in get_children():
		if child is Path2D:
			child.set_follow_loop(value)

func set_can_spawn(value:bool):
	can_spawn = value
	state_enemy_path(can_spawn)

func get_can_spawn():
	return can_spawn
