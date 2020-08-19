# Cena que representa o inimigo BlankeyEnemy
# que herda de Enemy
extends Enemy

# Inicialização
func _ready():
	$ASprite.play("flying")
	crystals = 2

# Mivimentação 
func _physics_process(delta):
	velocity = direction * speed * delta
	position += velocity
