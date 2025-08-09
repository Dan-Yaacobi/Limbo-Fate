class_name FlyingRoam extends EnemyMovement

enum directions{TOP_LEFT,TOP_RIGHT,BOTTOM_LEFT,BOTTOM_RIGHT}

var current_direction: directions

func move_function(_global_position: Vector2) -> bool:

	var new_direction = null

	var is_right = _global_position.x > GlobalPlayer.layer.global_position.x
	var is_above = _global_position.y < GlobalPlayer.global_position.y

	if is_right:
		new_direction = directions.TOP_RIGHT if is_above else directions.BOTTOM_RIGHT
	else:
		new_direction = directions.TOP_LEFT if is_above else directions.BOTTOM_LEFT

	if new_direction != current_direction:
		current_direction = new_direction
		return true

	return false
