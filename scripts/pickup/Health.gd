extends Pickup
class_name Health

export (Texture) var particle_texture
func _ready():
	direction = Vector2.DOWN
	speed = Vector2(30, 30)
	value = "HEALTH"

func _physics_process(delta):
	velocity = direction * speed * delta
	position += velocity

func on_pickup_body_entered(body):
	SoundManager.play_sfx("HealthPickup")
	get_tree().call_group("world", "update_health", 1, body)
	destroy()

func destroy():
	Global.create_popup(popup, position, value, Color.indianred, Color.bisque)
	Global.create_particle(particle, position, particle_texture)
	queue_free()
