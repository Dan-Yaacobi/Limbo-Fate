class_name ArrowAbility extends Resource

var arrow: Arrow
var ability_name: String

func activate_ability(_enemy: Enemy, _arrow: Arrow) -> void:
	pass

func set_ability(_arrow: Arrow) -> void:
	arrow = _arrow
