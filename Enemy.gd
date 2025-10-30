extends CharacterBody2D

# Stats de l'ennemi
@export var max_health: int = 50
@export var speed: float = 150.0
@export var attack_damage: int = 10
@export var attack_range: float = 160.0
@export var detection_range: float = 400.0

var current_health: int
var player = null
var is_attacking = false
var attack_cooldown = 1.0
var attack_timer = 0.0

func _ready():
	current_health = max_health

func _physics_process(delta):
	# Trouver le joueur si pas encore trouvé
	if not player:
		player = get_tree().get_first_node_in_group("player")
		return

	# Calculer distance au joueur
	var distance_to_player = global_position.distance_to(player.global_position)

	# Gestion du cooldown d'attaque
	if attack_timer > 0:
		attack_timer -= delta

	# Comportement selon la distance
	if distance_to_player < attack_range:
		# Assez proche pour attaquer
		attack_player()
	elif distance_to_player < detection_range:
		# Poursuivre le joueur
		chase_player()
	else:
		# Idle
		velocity = Vector2.ZERO

	move_and_slide()

func chase_player():
	if not player:
		return

	# Direction vers le joueur
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * speed

	# Flip sprite selon direction
	if has_node("Sprite2D") and direction.x != 0:
		$Sprite2D.flip_h = direction.x < 0

func attack_player():
	# Arrêter de bouger
	velocity = Vector2.ZERO

	# Attaquer si cooldown terminé
	if attack_timer <= 0 and not is_attacking:
		is_attacking = true
		attack_timer = attack_cooldown

		# Infliger dégâts au joueur
		if player and player.has_method("take_damage"):
			player.take_damage(attack_damage)

		is_attacking = false

func take_damage(amount: int, hit_direction: Vector2 = Vector2.ZERO):
	current_health -= amount

	# Audio: Play hit sound
	if has_node("HitSound"):
		$HitSound.play()

	# Knockback effect
	if hit_direction != Vector2.ZERO:
		velocity = hit_direction * 300.0

	# Enhanced visual flash with tween
	if has_node("Sprite2D"):
		var tween = create_tween()
		tween.tween_property($Sprite2D, "modulate", Color.RED, 0.05)
		tween.tween_property($Sprite2D, "modulate", Color.WHITE, 0.15)

	# Hit-stop for impact feel (brief freeze frame)
	get_tree().paused = true
	await get_tree().create_timer(0.03, true, false, true).timeout
	get_tree().paused = false

	# Mourir si HP = 0
	if current_health <= 0:
		die()

func die():
	# Notifier le DungeonManager
	var dungeon_manager = get_tree().get_first_node_in_group("dungeon_manager")
	if dungeon_manager and dungeon_manager.has_method("enemy_died"):
		dungeon_manager.enemy_died()

	# Supprimer l'ennemi
	queue_free()
