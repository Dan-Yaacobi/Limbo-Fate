class_name ArrowStats extends Resource

@export var base_dmg: float = 1
@export var dmg_modifier : float
@export var air_resistance: float
@export var weight: float

@export var ability: ArrowAbility :
	set(_val):
		ability = _val
		if arrow:
			ability.arrow = arrow

var arrow: Arrow

func set_arrow(_arrow: Arrow) -> void:
	if _arrow:
		arrow = _arrow
