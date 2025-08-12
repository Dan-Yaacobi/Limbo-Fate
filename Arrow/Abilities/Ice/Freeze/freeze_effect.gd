class_name FreezeEffect extends Effect

@onready var freeze_length: Timer = $FreezeLength

func _ready() -> void:
	if get_parent() is Enemy:
		enemy = get_parent()
		enemy.freeze(true)
		freeze_length.timeout.connect(freeze_over)
	else:
		freeze_over()

func set_freeze_length(amount: float) -> void:
	freeze_length.wait_time = amount
	freeze_length.start()

func _process(delta: float) -> void:
	if enemy.velocity != Vector2.ZERO:
		enemy.velocity = Vector2.ZERO

func freeze_over() -> void:
	if enemy:
		enemy.freeze(false)
	queue_free()
