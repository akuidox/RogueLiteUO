extends Node

# Simple camera shake system
var shake_amount = 0.0
var shake_time = 0.0

func _process(delta):
	if shake_time > 0:
		shake_time -= delta
		var camera = get_parent() as Camera2D
		if camera:
			camera.offset = Vector2(
				randf_range(-shake_amount, shake_amount),
				randf_range(-shake_amount, shake_amount)
			)
	else:
		var camera = get_parent() as Camera2D
		if camera:
			camera.offset = Vector2.ZERO

func shake(duration: float, intensity: float):
	shake_time = duration
	shake_amount = intensity
