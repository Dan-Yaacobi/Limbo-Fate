class_name BurnEffect extends Effect

@onready var burn_timer: Timer = $BurnTimer
@onready var burn_particle: CPUParticles2D = $BurnParticle
@onready var burn_tick: Timer = $BurnTick

@export var burn_damage: int = 1
@export var burn_color: Color
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_parent() is Enemy:
		enemy = get_parent()
		enemy.add_effect(effect_id,self)
		enemy.burn(true)
		
		burn_timer.timeout.connect(burn_over)
		burn_tick.timeout.connect(deal_burn_damage)
		burn_tick.start()
		burn_timer.start()
		
	else:
		burn_over()

func deal_burn_damage() -> void:
	if enemy:
		enemy.apply_dmg(burn_damage)
		CombatTextSpawner.spawn(enemy.global_position, str(burn_damage),burn_color)
		burn_tick.start()

func burn_over() -> void:
	if enemy:
		enemy.remove_effect(effect_id)
		enemy.burn(false)
	queue_free()
	pass

func reapply_effect() -> void:
	burn_timer.start()
	burn_tick.start()
