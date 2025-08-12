class_name EnemyMovement extends Resource

var enemy: Enemy

func move_function(delta) -> void:
	pass

func set_movement_function(_enemy: Enemy) -> void:
	if _enemy:
		enemy = _enemy

func calc_direction_to_player() -> Vector2:
	return (GlobalPlayer.global_position - enemy.global_position).normalized()
