class_name FrostbiteAbility extends ArrowAbility

@export_range(0, 100, 1, "suffix:%") var frostbite_dmg_mod: float = 30

@export var frost_color: Color = Color("28ddff")

func activate_ability(_enemy: Enemy, _arrow: Arrow) -> void:
	if _enemy and _arrow:
		if _enemy.is_chilled():
			_arrow.set_dmg_modifier(frostbite_dmg_mod/100)
			_arrow.set_dmg_color(frost_color)
			_arrow.set_hit_effect_color(frost_color)
