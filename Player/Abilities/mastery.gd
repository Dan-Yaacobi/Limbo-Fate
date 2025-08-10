class_name MasteryPlayerAbility extends PlayerOnShootAbility

@export var required_shots: int = 3

func activate_ability() -> void:
	if GlobalPlayer.get_perfect_shots_amount() % required_shots == 0 and GlobalPlayer.get_perfect_shots_amount() > 0:
		GlobalPlayer.make_next_shot_perfect()
