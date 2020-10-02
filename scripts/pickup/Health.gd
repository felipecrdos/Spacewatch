extends Pickup
class_name Health

func _ready():
	direction = Vector2.DOWN
	speed = Vector2(100, 100)
	value = "HEALTH"

func _physics_process(delta):
	velocity = direction * speed * delta
	position += velocity

func on_pickup_body_entered(body):
	get_tree().call_group("world", "update_health", 1, body)
	destroy()

func destroy():
	Global.create_popup(popup, position, value, Color.red)
	Global.create_particle(particle, position, Color.red)
	queue_free()
