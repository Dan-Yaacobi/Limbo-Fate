class_name SlowEffect extends Node2D

@onready var slowtimer: Timer = $Slowtimer
@onready var slow_effect: CPUParticles2D = $SlowEffect

var enemy: Enemy

func _ready() -> void:
	if get_parent() is Enemy:
		enemy = get_parent()
		enemy.slowed(true)
		slowtimer.timeout.connect(slow_over)
	else:
		slow_over()

#func _process(delta: float) -> void:
	#slow_effect.global_position = enemy.global_position

func set_slow_length(_amount: float) -> void:
	slowtimer.wait_time = _amount
	slowtimer.start()

func slow_over() -> void:
	if enemy:
		enemy.slowed(false)
	queue_free()
