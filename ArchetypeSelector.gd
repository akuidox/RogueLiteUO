extends Area2D

# Sélecteur d'archétype dans le hub
@export_enum("warrior", "mage", "support") var archetype: String = "warrior"
@export var display_name: String = "WARRIOR"

var player_inside = false
var label: Label = null

func _ready():
	# Connecter les signaux
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

	# Trouver ou créer le label
	if has_node("Label"):
		label = $Label
		update_label()

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_inside = true
		update_label()

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_inside = false
		update_label()

func _input(event):
	if player_inside and event.is_action_pressed("interact"):
		select_archetype()

func select_archetype():
	# Trouver le joueur
	var player = get_tree().get_first_node_in_group("player")
	if not player:
		return

	# Changer son archetype
	if player.has_method("set_archetype"):
		player.set_archetype(archetype)
	else:
		player.archetype = archetype

	# Feedback visuel
	if label:
		label.modulate = Color.GREEN
		await get_tree().create_timer(0.3).timeout
		update_label()

	print("Archetype sélectionné: ", archetype)

func update_label():
	if not label:
		return

	if player_inside:
		label.text = "[E] SELECT " + display_name
		label.modulate = Color.YELLOW
	else:
		label.text = display_name
		label.modulate = Color.WHITE
