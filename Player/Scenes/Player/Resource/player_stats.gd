class_name PlayerStats extends Resource

@export_subgroup("Base Stats")
@export var max_hp: int = 10
@export var current_hp: int = 10
@export var knockback_resistance: float = 0
@export var strength: int
@export var agility: int

@export_subgroup("Shooting Stats")
@export var max_pull_strength: float
@export var basic_shot_power: float = 150
@export var pull_speed: float = 1:
	get:
		return pull_speed
	set(value):
		pull_speed = clamp(value,1,2.5)


@export_subgroup("Movement")
@export var move_speed: float
@export var min_move_shoot_spd: float
@export var gravity: float
@export var jump_power: float
@export var total_jumps: int = 1
@export var can_dash: bool = false
@export var dash_length: float = 1.0
@export var dash_speed: float = 20

@export_subgroup("SpecialAbilities")
@export var arrow_ability: ArrowAbility
