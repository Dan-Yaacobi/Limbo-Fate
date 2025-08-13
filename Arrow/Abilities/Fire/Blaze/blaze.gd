class_name BlazeAbility extends ArrowAbility

func activate_ability(_enemy: Enemy, _arrow: Arrow) -> void:
	if _enemy.is_burnt():
		GlobalPlayer
