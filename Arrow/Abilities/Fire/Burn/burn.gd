class_name BurnAbility extends ArrowAbility

const BURN_EFFECT = preload("res://Arrow/Abilities/Fire/Burn/BurnEffect.tscn")

@export var required_perfects: int = 2

func activate_ability(_enemy: Enemy, _arrow: Arrow) -> void:
	if _enemy:
		if GlobalPlayer.get_perfect_shots_amount() % required_perfects == 0 and GlobalPlayer.get_perfect_shots_amount() > 1:
			burn_enemy(_enemy)

func burn_enemy(_enemy: Enemy) -> void:
	var burn_effect = BURN_EFFECT.instantiate()
	if _enemy.is_burnt():
		var effect = _enemy.get_effect(burn_effect.effect_id)
		if effect:
			effect.reapply_effect()
	else:
		_enemy.add_child(burn_effect)
