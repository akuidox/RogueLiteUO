extends Node2D

# Gestion du donjon
@export var difficulty: String = "EASY"
@export var num_enemies: int = 3

var enemies_alive = 0
var player = null

# Stats tracking
var start_time: float = 0.0
var total_enemies: int = 0
var enemies_killed: int = 0

# ResultScreen preload
const ResultScreen = preload("res://ResultScreen.gd")

func _ready():
	# Trouver le joueur
	player = get_tree().get_first_node_in_group("player")
	if not player:
		return

	# Initialiser stats tracking
	start_time = Time.get_ticks_msec() / 1000.0

	# Compter les ennemis au départ
	enemies_alive = get_tree().get_nodes_in_group("enemy").size()
	total_enemies = enemies_alive
	enemies_killed = 0
	update_enemy_count()

func enemy_died():
	enemies_alive -= 1
	enemies_killed += 1

	if enemies_alive <= 0:
		victory()

func update_enemy_count():
	# Recompter les ennemis vivants
	enemies_alive = get_tree().get_nodes_in_group("enemy").size()

func victory():
	# Calculer stats
	var end_time = Time.get_ticks_msec() / 1000.0
	var run_time = end_time - start_time

	var damage_dealt = 0
	if player and player.has_method("get_damage_dealt"):
		damage_dealt = player.get_damage_dealt()

	var stats = {
		"time": run_time,
		"kills": enemies_killed,
		"damage_dealt": damage_dealt
	}

	# Afficher écran de victoire
	show_result_screen(ResultScreen.ResultType.VICTORY, stats)

func show_result_screen(type, stats: Dictionary):
	# Créer et afficher l'écran de résultat
	var result_screen = CanvasLayer.new()
	result_screen.set_script(ResultScreen)
	get_tree().root.add_child(result_screen)
	result_screen.setup(type, stats)

func return_to_hub():
	get_tree().change_scene_to_file("res://hub.tscn")
