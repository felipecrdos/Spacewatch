# Cena que representa o inimigo BlankeyEnemy
# que herda de Enemy
extends Enemy

# Inicialização
func _ready():
	$ASprite.play("flying")
	score = 1
	health = 10

# Movimentação 
func _physics_process(delta):
	velocity = direction * speed * delta
	position += velocity
