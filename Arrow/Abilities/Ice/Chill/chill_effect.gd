class_name ChillEffect extends Effect

@onready var chill_timer: Timer = $ChillTimer
@onready var chill_effect: CPUParticles2D = $ChillEffect

@export var slow_amount: float = 0.7

func _ready() -> void:
	if get_parent() is Enemy:
		enemy = get_parent()
		enemy.add_effect(effect_id,self)
		enemy.chilled(true,slow_amount)
		chill_timer.timeout.connect(end_effect)
	else:
		end_effect()

func apply_effect() -> void:
	chill_timer.start()

func end_effect() -> void:
	if enemy:
		enemy.chilled(false)
	enemy.remove_effect(effect_id)
	queue_free()

func reapply_effect() -> void:
	chill_timer.start()
