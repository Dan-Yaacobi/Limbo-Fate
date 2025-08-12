class_name EnemyStats extends Resource

@export_subgroup("Base Stats")
@export var max_hp: int
@export var current_hp: int
@export var touch_damage: int

@export_subgroup("Movement")
@export var move_speed: float 
@export var max_speed: float
@export var move_function: EnemyMovement

@export_subgroup("Effects")
@export var frozen: bool = false
@export var chilled: bool = false
@export_range(0.0,1,0.05) var slowed_amount: float = 1.0
@export var extra_dmg_mod: float = 1.0
@export var burned: bool = false
