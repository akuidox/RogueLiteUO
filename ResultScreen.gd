extends CanvasLayer

# Écran de résultat (victoire ou défaite)

enum ResultType { VICTORY, DEFEAT }

var result_type: ResultType = ResultType.VICTORY
var stats: Dictionary = {
	"time": 0.0,
	"kills": 0,
	"damage_dealt": 0
}

var panel: PanelContainer = null
var return_timer: float = 3.0

func _ready():
	create_ui()
	update_display()

func _process(delta):
	# Auto-return après 3 secondes
	return_timer -= delta
	if return_timer <= 0:
		return_to_hub()

func _input(event):
	# Ou retour immédiat avec E
	if event.is_action_pressed("interact"):
		return_to_hub()

func setup(type: ResultType, run_stats: Dictionary):
	result_type = type
	stats = run_stats

func create_ui():
	# Panel central semi-transparent
	panel = PanelContainer.new()
	panel.position = Vector2(660, 340)  # Centré environ
	panel.size = Vector2(600, 400)
	add_child(panel)

	# Fond sombre transparent
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.1, 0.1, 0.1, 0.9)
	style.border_width_all = 3
	panel.add_theme_stylebox_override("panel", style)

	# VBox pour le layout
	var vbox = VBoxContainer.new()
	vbox.alignment = BoxContainer.ALIGNMENT_CENTER
	panel.add_child(vbox)

	# Spacer
	var spacer1 = Control.new()
	spacer1.custom_minimum_size = Vector2(0, 40)
	vbox.add_child(spacer1)

	# Titre (VICTORY ou DEFEATED)
	var title = Label.new()
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 48)
	vbox.add_child(title)

	# Spacer
	var spacer2 = Control.new()
	spacer2.custom_minimum_size = Vector2(0, 30)
	vbox.add_child(spacer2)

	# Stats labels
	var time_label = Label.new()
	time_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	time_label.add_theme_font_size_override("font_size", 20)
	vbox.add_child(time_label)

	var kills_label = Label.new()
	kills_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	kills_label.add_theme_font_size_override("font_size", 20)
	vbox.add_child(kills_label)

	var damage_label = Label.new()
	damage_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	damage_label.add_theme_font_size_override("font_size", 20)
	vbox.add_child(damage_label)

	# Spacer
	var spacer3 = Control.new()
	spacer3.custom_minimum_size = Vector2(0, 40)
	vbox.add_child(spacer3)

	# Message d'encouragement
	var message = Label.new()
	message.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	message.add_theme_font_size_override("font_size", 18)
	vbox.add_child(message)

	# Spacer
	var spacer4 = Control.new()
	spacer4.custom_minimum_size = Vector2(0, 20)
	vbox.add_child(spacer4)

	# Instructions
	var instructions = Label.new()
	instructions.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	instructions.add_theme_font_size_override("font_size", 16)
	instructions.text = "[E] Return to Hub  |  Auto-return in 3s..."
	vbox.add_child(instructions)

func update_display():
	if not panel:
		return

	var vbox = panel.get_child(0) as VBoxContainer
	var title = vbox.get_child(1) as Label
	var time_label = vbox.get_child(3) as Label
	var kills_label = vbox.get_child(4) as Label
	var damage_label = vbox.get_child(5) as Label
	var message = vbox.get_child(7) as Label

	# Update selon type
	if result_type == ResultType.VICTORY:
		title.text = "VICTORY!"
		title.modulate = Color.GREEN

		# Style bordure verte
		var style = panel.get_theme_stylebox("panel").duplicate()
		style.border_color = Color.GREEN
		panel.add_theme_stylebox_override("panel", style)

		# Message d'encouragement
		message.text = "Dungeon cleared! Try a harder difficulty?"
		message.modulate = Color.YELLOW

	else:  # DEFEAT
		title.text = "DEFEATED"
		title.modulate = Color.RED

		# Style bordure rouge
		var style = panel.get_theme_stylebox("panel").duplicate()
		style.border_color = Color.RED
		panel.add_theme_stylebox_override("panel", style)

		# Message d'encouragement
		message.text = "Try again with a different archetype?"
		message.modulate = Color.YELLOW

	# Update stats
	var time_str = "%.1f" % stats.get("time", 0)
	time_label.text = "Time: %s seconds" % time_str

	var kills = stats.get("kills", 0)
	kills_label.text = "Enemies Killed: %d" % kills

	var damage = stats.get("damage_dealt", 0)
	damage_label.text = "Damage Dealt: %d" % damage

func return_to_hub():
	get_tree().change_scene_to_file("res://hub.tscn")
