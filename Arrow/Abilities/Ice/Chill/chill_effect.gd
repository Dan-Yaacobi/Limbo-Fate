class_name SlowEffect extends Effect

@onready var slowtimer: Timer = $Slowtimer
@onready var slow_effect: CPUParticles2D = $SlowEffect

@export var slow_amount: float = 0.7

var enemy: Enemy

func _ready() -> void:
	if get_parent() is Enemy:
		enemy = get_parent()
		enemy.add_effect(effect_id,self)
		enemy.chilled(true,slow_amount)
		slowtimer.timeout.connect(slow_over)
	else:
		slow_over()

func set_slow_length(_amount: float) -> void:
	slowtimer.wait_time = _amount
	slowtimer.start()

func slow_over() -> void:
	if enemy:
		enemy.chilled(false)
	enemy.remove_effect(effect_id)
	queue_free()

func reapply_effect() -> void:
	slowtimer.start()
