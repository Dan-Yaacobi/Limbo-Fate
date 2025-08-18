class_name PlayerStats extends Resource

@export_subgroup("Base Stats")
@export var max_hp: int = 10
@export var current_hp: int = 10
@export var knockback_resistance: float = 0
@export var strength: int
@export var agility: int
@export var stamina: int

@export_subgroup("Shooting Stats")
@export var max_pull_strength: float
@export var basic_shot_power: StatVar = StatVar.new()
@export var pull_speed: float = 1:
	get:
		return pull_speed
	set(value):
		pull_speed = clamp(value,1,4)

@export_subgroup("Movement")
@export var move_speed: StatVar = StatVar.new()
@export var min_move_shoot_spd: StatVar = StatVar.new()
@export var gravity: StatVar = StatVar.new()
@export var jump_power: StatVar = StatVar.new()
@export var total_jumps: int = 1
@export var dash_length: StatVar = StatVar.new()
@export var dash_speed: StatVar = StatVar.new()
@export var can_dash: bool = false

@export_subgroup("SpecialAbilities")
@export var arrow_abilities: Array[ArrowAbility]
@export var shoot_abilities: Array[PlayerOnShootAbility]


func get_stat(stat_name: StringName) -> StatVar:
	return get(stat_name) as StatVar

class Stat:
	const SPEED: StringName = &"move_speed"
	const GRAVITY: StringName = &"gravity"
	const JUMP_POWER: StringName = &"jump_power"
	const DASH_SPEED: StringName = &"dash_speed"
	const STRENGTH: StringName = &"strength"
	const AGILITY: StringName = &"agility"
