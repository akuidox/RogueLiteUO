extends ProgressBar

# Référence au joueur (ou ennemi)
var target = null

func _ready():
	# Trouver le parent (joueur ou ennemi)
	target = get_parent()

	# Attendre 1 frame pour que le parent soit bien initialisé
	await get_tree().process_frame

	if target:
		# Configurer la barre selon les HP max
		max_value = target.max_health
		value = target.current_health

func _process(delta):
	if target and is_instance_valid(target):
		# Mettre à jour la valeur
		value = target.current_health
	else:
		# Si le target n'existe plus, supprimer la barre
		queue_free()
