class_name BurnEffect extends Effect

@onready var burn_timer: Timer = $BurnTimer
@onready var burn_particle: CPUParticles2D = $BurnParticle
@onready var burn_tick: Timer = $BurnTick

@export var burn_damage: int = 1
@export var burn_color: Color

func _ready() -> void:
	if get_parent() is Enemy:
		enemy = get_parent()
		enemy.add_effect(effect_id,self)
		enemy.burn(true)
		
		burn_timer.timeout.connect(end_effect)
		burn_tick.timeout.connect(apply_effect)
		burn_tick.start()
		burn_timer.start()
	else:
		end_effect()

func apply_effect() -> void:
	if enemy:
		enemy.apply_dmg(burn_damage)
		CombatTextSpawner.spawn(enemy.global_position, str(burn_damage),burn_color)
		burn_tick.start()


func end_effect() -> void:
	if enemy:
		enemy.remove_effect(effect_id)
		enemy.burn(false)
	queue_free()

func reapply_effect() -> void:
	burn_timer.start()
	burn_tick.start()
