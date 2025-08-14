class_name ExplosionHurtBox extends HurtBox

func added_effects(a: Enemy) -> void:
	if a is Enemy:
		var burn = BurnAbility.new()
		burn.burn_enemy(a)
