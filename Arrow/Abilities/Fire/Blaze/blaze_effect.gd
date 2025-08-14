extends CPUParticles2D
var base_gravity: float = 100

func _process(delta: float) -> void:
	if GlobalPlayer.direction != 0:
		gravity = Vector2(base_gravity * -GlobalPlayer.direction, 5)
	else:
		gravity = Vector2(0,-1 * base_gravity)
