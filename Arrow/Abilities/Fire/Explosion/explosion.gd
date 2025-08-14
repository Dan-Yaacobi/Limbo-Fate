class_name ExplosionAbility extends ArrowAbility

const EXPLOSION_EFFECT = preload("res://Arrow/Abilities/Fire/Explosion/ExplosionEffect.tscn")
@export var required_perfect_shots: int = 3
@export var explosion_damage: int = 10
func activate_ability(_enemy: Enemy, _arrow: Arrow) -> void:
	if _enemy:
		if GlobalPlayer.get_perfect_shots_amount() % required_perfect_shots == 0 and GlobalPlayer.get_perfect_shots_amount() > 0:
			var explosion_effect = EXPLOSION_EFFECT.instantiate()
			_enemy.call_deferred("add_child", explosion_effect)
			explosion_effect.set_explosion(explosion_damage)
