extends Area2D

# Projectile pour attaques à distance (mage, ranger enemies)
@export var speed: float = 400.0
@export var max_distance: float = 600.0
@export var damage: int = 10
@export var owner_group: String = "player"  # "player" or "enemy" pour ignorer le tireur

var direction: Vector2 = Vector2.RIGHT
var traveled_distance: float = 0.0
var start_position: Vector2

func _ready():
	start_position = global_position

	# Connecter la détection de collision
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)

func _physics_process(delta):
	# Déplacer le projectile
	var movement = direction * speed * delta
	global_position += movement
	traveled_distance += movement.length()

	# Détruire si distance max atteinte
	if traveled_distance >= max_distance:
		queue_free()

func _on_body_entered(body):
	# Ignorer le tireur
	if body.is_in_group(owner_group):
		return

	# Si c'est un ennemi ou joueur, infliger dégâts
	var target_group = "enemy" if owner_group == "player" else "player"
	if body.is_in_group(target_group):
		if body.has_method("take_damage"):
			# Calculer direction du hit pour knockback
			var hit_direction = direction.normalized()
			body.take_damage(damage, hit_direction)

		# Détruire le projectile
		queue_free()

func _on_area_entered(area):
	# Collision avec autres projectiles ou zones - ignorer pour l'instant
	pass

func setup(start_pos: Vector2, dir: Vector2, dmg: int, owner: String):
	global_position = start_pos
	start_position = start_pos
	direction = dir.normalized()
	damage = dmg
	owner_group = owner

	# Orienter le sprite selon la direction
	rotation = direction.angle()
