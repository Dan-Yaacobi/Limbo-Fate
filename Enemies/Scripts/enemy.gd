class_name Enemy extends CharacterBody2D

@export var stats: EnemyStats
@onready var hit_box: HitBox = $Hitbox
@onready var hurt_box: HurtBox = $HurtBox

var effects: Dictionary = {}

func _ready() -> void:
	hit_box.Damaged.connect(_take_hit)
	stats.current_hp = stats.max_hp
	if stats.move_function:
		stats.move_function.set_movement_function(self)
	
func _process(_delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if not stats.frozen:
		apply_movement(delta)
	move_and_slide()

func _take_hit(_hurt_box: HurtBox) -> void:
	
	#apply_dmg(dmg)
	#knocked_back(kb_power, kb_direction)
	apply_dmg(_hurt_box.damage)
	velocity = Vector2.ZERO
	
func dead() -> void:
	queue_free()
	pass
	
func apply_dmg(dmg: int) -> void:
	stats.current_hp -= floor(dmg * stats.extra_dmg_mod)
	if stats.current_hp <= 0:
		dead()

func knocked_back(power: float, direction: Vector2) -> void:
	if power > 0:
		velocity = Vector2.ZERO
		velocity = direction * power

func freeze(state: bool) -> void:
	stats.frozen = state
	
func chilled(state:bool,amount: float = 1.0) -> void:
	stats.chilled = state
	stats.slowed_amount = amount

func drop_items() -> void:
	pass

func apply_movement(delta) -> void:
	if stats.move_function:
		stats.move_function.move_function(delta)

func is_chilled() -> bool:
	return stats.chilled

func add_effect(effect_id: int, effect: Effect) -> void:
	effects[effect_id] = effect

func remove_effect(effect_id: int) -> void:
	effects.erase(effect_id)

func get_effect(effect_id: int) -> Effect:
	if effects.has(effect_id):
		return effects[effect_id]
	return null
