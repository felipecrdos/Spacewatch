extends Pickup
class_name Powerup

func _ready():
	direction = Vector2.DOWN
	speed = Vector2(100, 100)
	value = "POWERUP"

func _physics_process(delta):
	velocity = direction * speed * delta
	position += velocity

func on_pickup_body_entered(body):
	get_tree().call_group("world", "update_powerup", 1, body)
	destroy()

func destroy():
	Global.create_popup(popup, position, value, Color.yellow)
	Global.create_particle(particle, position, Color.yellow)
	queue_free()
