class_name Enemy extends CharacterBody2D

@export var stats: EnemyStats
@onready var hit_box: HitBox = $Hitbox
@onready var hurt_box: HurtBox = $HurtBox

enum directions{TOP_LEFT,TOP_RIGHT,BOTTOM_LEFT,BOTTOM_RIGHT}

var current_direction: directions

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	velocity += calc_direction_to_player() * stats.move_speed
	
func calc_direction_to_player() -> Vector2:
	return (GlobalPlayer.global_position - global_position).normalized()

func take_hit(dmg: int, kb_power: float = 0, kb_direction: Vector2 = Vector2.ZERO) -> void:
	apply_dmg(dmg)
	knocked_back(kb_power, kb_direction)
	
func dead() -> void:
	pass
	
func apply_dmg(dmg: int) -> void:
	stats.current_hp -= dmg
	if stats.current_hp <= 0:
		dead()

func knocked_back(power: float, direction: Vector2) -> void:
	if power > 0:
		velocity = Vector2.ZERO
		velocity = direction * power
	
func touch_player() -> void:
	pass

func drop_items() -> void:
	pass

func apply_movement() -> void:
	pass
	
func change_direction() -> bool:
	#if not stats.sharp_movement:
		#return false

	var new_direction = null

	var is_right = global_position.x > GlobalPlayer.layer.global_position.x
	var is_above = global_position.y < GlobalPlayer.global_position.y

	if is_right:
		new_direction = directions.TOP_RIGHT if is_above else directions.BOTTOM_RIGHT
	else:
		new_direction = directions.TOP_LEFT if is_above else directions.BOTTOM_LEFT

	if new_direction != current_direction:
		current_direction = new_direction
		return true

	return false
