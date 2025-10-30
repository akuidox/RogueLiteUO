extends CharacterBody2D

# Stats du joueur
var speed = 200.0
var archetype = "warrior"  # warrior, mage, support

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
	var damage = skills["combat"] / 10

	# Détecter les ennemis proches (dans un rayon de 200 pixels)
	var attack_range = 200.0
	var enemies = get_tree().get_nodes_in_group("enemy")

	for enemy in enemies:
		if enemy and is_instance_valid(enemy):
			var distance = global_position.distance_to(enemy.global_position)

			if distance <= attack_range:
				# Infliger dégâts
				if enemy.has_method("take_damage"):
					enemy.take_damage(int(damage))

func take_damage(amount: int):
	current_health -= amount

	if current_health <= 0:
		die()

func die():
	# Retourner au hub après un court délai
	await get_tree().create_timer(1.5).timeout
	get_tree().change_scene_to_file("res://hub.tscn")
