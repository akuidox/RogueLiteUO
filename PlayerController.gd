extends CharacterBody2D

# Stats du joueur
var speed = 300.0
var archetype = "warrior"  # warrior, mage, support

# Combat
var attack_cooldown_time = 0.4
var attack_cooldown_timer = 0.0
var can_attack = true

# Skills (seront randomisées au portal)
var skills = {
	"combat": 50,
	"magic": 0,
	"support": 0,
	"health": 100
}

var current_health = 100
var max_health = 100

func _ready():
	# Initialiser selon archetype
	setup_archetype(archetype)

func _physics_process(delta):
	# Récupérer input du joueur
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	# Appliquer mouvement
	if input_dir:
		velocity = input_dir * speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, speed)

	move_and_slide()

	# Flip sprite selon direction
	if input_dir.x != 0:
		$Sprite2D.flip_h = input_dir.x < 0

	# Update attack cooldown
	if attack_cooldown_timer > 0:
		attack_cooldown_timer -= delta
		if attack_cooldown_timer <= 0:
			can_attack = true

func _input(event):
	if event.is_action_pressed("attack"):
		attack()

func setup_archetype(type: String):
	match type:
		"warrior":
			skills["combat"] = 80
			skills["magic"] = 0
			skills["support"] = 20
			max_health = 150
		"mage":
			skills["combat"] = 20
			skills["magic"] = 80
			skills["support"] = 0
			max_health = 80
		"support":
			skills["combat"] = 30
			skills["magic"] = 30
			skills["support"] = 80
			max_health = 100

	current_health = max_health

func randomize_skills():
	# Randomiser les skills (appelé au portal)
	match archetype:
		"warrior":
			skills["combat"] = randi_range(60, 100)
			skills["support"] = randi_range(0, 40)
		"mage":
			skills["magic"] = randi_range(60, 100)
			skills["support"] = randi_range(0, 40)
		"support":
			skills["support"] = randi_range(60, 100)
			skills["combat"] = randi_range(20, 50)

func attack():
	# Check cooldown
	if not can_attack:
		return

	can_attack = false
	attack_cooldown_timer = attack_cooldown_time

	var damage = skills["combat"] / 10

	# Visual feedback: sprite pulse
	var tween = create_tween()
	tween.tween_property($Sprite2D, "scale", Vector2(1.2, 1.2), 0.1)
	tween.tween_property($Sprite2D, "scale", Vector2(1.0, 1.0), 0.1)

	# Audio: Play attack sound
	if has_node("AttackSound"):
		$AttackSound.play()

	# Détecter les ennemis proches (dans un rayon de 200 pixels)
	var attack_range = 200.0
	var enemies = get_tree().get_nodes_in_group("enemy")
	var hit_something = false

	for enemy in enemies:
		if enemy and is_instance_valid(enemy):
			var distance = global_position.distance_to(enemy.global_position)

			if distance <= attack_range:
				hit_something = true

				# Calculer direction du knockback
				var hit_direction = (enemy.global_position - global_position).normalized()

				# Infliger dégâts avec direction
				if enemy.has_method("take_damage"):
					enemy.take_damage(int(damage), hit_direction)

	# Camera shake if we hit something
	if hit_something and has_node("Camera2D"):
		var camera = $Camera2D
		if camera.has_node("CameraShake"):
			camera.get_node("CameraShake").shake(0.2, 5.0)

func take_damage(amount: int):
	current_health -= amount

	# Audio: Play hit sound
	if has_node("HitSound"):
		$HitSound.play()

	# Camera shake when taking damage (stronger than attack shake)
	if has_node("Camera2D"):
		var camera = $Camera2D
		if camera.has_node("CameraShake"):
			camera.get_node("CameraShake").shake(0.3, 8.0)

	if current_health <= 0:
		die()

func die():
	# Retourner au hub après un court délai
	await get_tree().create_timer(1.5).timeout
	get_tree().change_scene_to_file("res://hub.tscn")
