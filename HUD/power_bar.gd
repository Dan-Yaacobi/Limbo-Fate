class_name PowerBar extends TextureProgressBar

@onready var circle_filled: Sprite2D = $CircleFilled

signal full_bar

func _ready() -> void:
	EventBus.shot_power.connect(fill_bar)
	value = 0

func fill_bar(amount) -> void:
	value += ceil(pow(amount,2) * 25)
	if value >= max_value:
		full_bar.emit()
		circle_filled.frame = 1
	else:
		circle_filled.frame = 0
