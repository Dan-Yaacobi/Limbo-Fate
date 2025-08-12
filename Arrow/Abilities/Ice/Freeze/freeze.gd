class_name FreezeAbility extends ArrowAbility

const FREEZE_EFFECT = preload("res://Arrow/Abilities/Ice/Freeze/FreezeEffect.tscn")

@export var required_perfect_shots: int = 3
@export var freeze_duration: float = 3.0

## after a set amount of perfect shots in a row  - freezes the enemy ##
func activate_ability(_enemy: Enemy, _arrow: Arrow) -> void:
	if _enemy:
		if GlobalPlayer.get_perfect_shots_amount() % required_perfect_shots == 0 and GlobalPlayer.get_perfect_shots_amount() > 0:
			var freeze_effect = FREEZE_EFFECT.instantiate()
			_enemy.add_child(freeze_effect)
			freeze_effect.set_freeze_length(freeze_duration)
