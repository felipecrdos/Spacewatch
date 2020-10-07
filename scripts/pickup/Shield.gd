extends Pickup
class_name Shield

export (Texture) var particle_texture
func _ready():
	direction = Vector2.DOWN
	speed = Vector2(30, 30)
	value = "SHIELD"

func _physics_process(delta):
	velocity = direction * speed * delta
	position += velocity

func on_pickup_body_entered(body):
	SoundManager.play_sfx("SuperPickup")
	get_tree().call_group("world", "update_shield", 1, body)
	destroy()

func destroy():
	Global.create_popup(popup, position, value, Color.cyan, Color.bisque)
	Global.create_particle(particle, position, particle_texture)
	queue_free()
