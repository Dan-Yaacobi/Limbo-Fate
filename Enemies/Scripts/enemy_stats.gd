class_name EnemyStats extends Resource

@export_subgroup("Base Stats")
@export var max_hp: int
@export var current_hp: int
@export var touch_damage: int


@export_subgroup("Movement")
@export var curr_speed: float
@export var curr_max_speed: float
@export var move_speed: float :
	set(_val):
		move_speed = _val
		slowed_speed = move_speed / 2
@export var max_speed: float:
	set(_val):
		max_speed = _val
		max_slowed_speed = max_speed / 2
@export var slowed_speed: float
@export var max_slowed_speed: float

@export_subgroup("Effects")
@export var frozen: bool = false
@export var slowed: bool = false
