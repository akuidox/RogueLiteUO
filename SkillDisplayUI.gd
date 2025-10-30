extends CanvasLayer

# UI pour afficher les skills du joueur en haut à gauche

var player = null
var archetype_label: Label = null
var combat_label: Label = null
var magic_label: Label = null
var support_label: Label = null
var health_label: Label = null

func _ready():
	# Créer le UI container
	create_ui()

	# Trouver le joueur
	await get_tree().process_frame
	player = get_tree().get_first_node_in_group("player")

	if player:
		update_display()

func create_ui():
	# Panel container
	var panel = PanelContainer.new()
	panel.position = Vector2(10, 10)
	panel.size = Vector2(200, 150)
	add_child(panel)

	# VBoxContainer pour organiser les labels
	var vbox = VBoxContainer.new()
	panel.add_child(vbox)

	# Archetype label (en gros)
	archetype_label = Label.new()
	archetype_label.add_theme_font_size_override("font_size", 20)
	archetype_label.text = "WARRIOR"
	vbox.add_child(archetype_label)

	# Separator
	var separator = HSeparator.new()
	vbox.add_child(separator)

	# Skill labels
	combat_label = Label.new()
	combat_label.text = "Combat: 80"
	vbox.add_child(combat_label)

	magic_label = Label.new()
	magic_label.text = "Magic: 0"
	vbox.add_child(magic_label)

	support_label = Label.new()
	support_label.text = "Support: 20"
	vbox.add_child(support_label)

	# Separator
	var separator2 = HSeparator.new()
	vbox.add_child(separator2)

	# Health label
	health_label = Label.new()
	health_label.text = "HP: 100 / 100"
	vbox.add_child(health_label)

func _process(delta):
	if player and is_instance_valid(player):
		update_display()

func update_display():
	if not player:
		return

	# Update archetype
	archetype_label.text = player.archetype.to_upper()

	# Get skills
	var skills = player.skills
	var combat = skills.get("combat", 0)
	var magic = skills.get("magic", 0)
	var support_skill = skills.get("support", 0)

	# Find highest skill pour color-coding
	var highest = max(combat, magic, support_skill)

	# Update labels avec color-coding
	combat_label.text = "Combat: %d" % combat
	combat_label.modulate = Color.GREEN if combat == highest and combat > 0 else Color.WHITE

	magic_label.text = "Magic: %d" % magic
	magic_label.modulate = Color.GREEN if magic == highest and magic > 0 else Color.WHITE

	support_label.text = "Support: %d" % support_skill
	support_label.modulate = Color.GREEN if support_skill == highest and support_skill > 0 else Color.WHITE

	# Update health
	health_label.text = "HP: %d / %d" % [player.current_health, player.max_health]

	# Color health based on percentage
	var health_percent = float(player.current_health) / float(player.max_health)
	if health_percent > 0.6:
		health_label.modulate = Color.GREEN
	elif health_percent > 0.3:
		health_label.modulate = Color.YELLOW
	else:
		health_label.modulate = Color.RED
