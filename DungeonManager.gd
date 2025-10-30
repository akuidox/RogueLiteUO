extends Node2D

# Gestion du donjon
@export var difficulty: String = "EASY"
@export var num_enemies: int = 3

var enemies_alive = 0
var player = null

func _ready():
	# Trouver le joueur
	player = get_tree().get_first_node_in_group("player")
	if not player:
		return

	# Compter les ennemis au départ
	enemies_alive = get_tree().get_nodes_in_group("enemy").size()
	update_enemy_count()

func enemy_died():
	enemies_alive -= 1

	if enemies_alive <= 0:
		victory()

func update_enemy_count():
	# Recompter les ennemis vivants
	enemies_alive = get_tree().get_nodes_in_group("enemy").size()

func victory():
	await get_tree().create_timer(2.0).timeout
	return_to_hub()

func return_to_hub():
	get_tree().change_scene_to_file("res://hub.tscn")
