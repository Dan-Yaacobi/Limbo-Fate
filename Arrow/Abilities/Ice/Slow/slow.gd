class_name SlowAbility extends ArrowAbility

const SLOW_EFFECT = preload("res://Arrow/Abilities/Ice/Slow/SlowEffect.tscn")
@export var required_perfects: int = 2
@export var slow_length: float = 4

func activate_ability(_enemy: Enemy) -> void:
	if _enemy:
		if GlobalPlayer.get_perfect_shots_amount() % required_perfects == 0 and GlobalPlayer.get_perfect_shots_amount() > 1:
			var slow_effect = SLOW_EFFECT.instantiate()
			_enemy.add_child(slow_effect)
			slow_effect.set_slow_length(slow_length)
