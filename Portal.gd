extends Area2D

# Difficulté du donjon
enum Difficulty { EASY, CHALLENGING, HARD }
@export var difficulty: Difficulty = Difficulty.EASY

# Couleurs selon difficulté
var difficulty_colors = {
	Difficulty.EASY: Color(0.3, 0.5, 1.0),  # Bleu
	Difficulty.CHALLENGING: Color(1.0, 0.8, 0.2),  # Jaune
	Difficulty.HARD: Color(1.0, 0.2, 0.2)  # Rouge
}

# Donjons disponibles par difficulté
var dungeon_scenes = {
	Difficulty.EASY: [
		"res://test_dungeon.tscn"
	],
	Difficulty.CHALLENGING: [
		"res://test_dungeon.tscn"
	],
	Difficulty.HARD: [
		"res://test_dungeon.tscn"
	]
}

var player_inside = false
var cooldown = false

func _ready():
	# Connecter le signal de détection
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	# Appliquer la couleur selon difficulté
	if has_node("Sprite2D"):
		$Sprite2D.modulate = difficulty_colors[difficulty]

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_inside = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_inside = false

func _input(event):
	if player_inside and event.is_action_pressed("interact") and not cooldown:
		enter_dungeon()

func enter_dungeon():
	cooldown = true

	# Trouver le joueur
	var player = get_tree().get_first_node_in_group("player")
	if not player:
		return

	# SIMPLIFIED: No skill randomization
	# Skills are now fixed per archetype for clarity
	# (Can re-enable randomization later for build variety)

	# Choisir un dongeon aléatoire
	var dungeons = dungeon_scenes[difficulty]
	var chosen_dungeon = dungeons[randi() % dungeons.size()]

	# Charger le donjon
	if ResourceLoader.exists(chosen_dungeon):
		get_tree().change_scene_to_file(chosen_dungeon)
