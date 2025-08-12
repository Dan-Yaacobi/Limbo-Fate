class_name SlowAbility extends ArrowAbility

const CHILL_EFFECT = preload("res://Arrow/Abilities/Ice/Chill/ChillEffect.tscn")

@export var required_perfects: int = 2
@export var slow_length: float = 4

func activate_ability(_enemy: Enemy, _arrow: Arrow) -> void:
	if _enemy:
		if GlobalPlayer.get_perfect_shots_amount() % required_perfects == 0 and GlobalPlayer.get_perfect_shots_amount() > 1:
			var chill_effect = CHILL_EFFECT.instantiate()
			if _enemy.is_chilled():
				var effect = _enemy.get_effect(chill_effect.effect_id)
				if effect:
					effect.reapply_effect()
			else:
				_enemy.add_child(chill_effect)
				chill_effect.set_slow_length(slow_length)
