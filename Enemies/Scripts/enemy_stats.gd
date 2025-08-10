class_name EnemyStats extends Resource

@export_category("Base Stats")
@export var max_hp: int
@export var current_hp: int
@export var touch_damage: int


@export_category("Movement")
@export var move_speed: float
@export var max_speed: float


@export_category("Effects")
@export var frozen: bool = false
