class_name ArrowDissapearNotifier extends VisibleOnScreenNotifier2D

@onready var timer: Timer = $Timer

var arrow: Arrow

func _ready() -> void:
	if get_parent() is Arrow:
		arrow = get_parent()
		timer.timeout.connect(arrow.queue_free)
		screen_exited.connect(start)
		screen_entered.connect(stop)
		
func start() -> void:
	arrow.shot_missed()
	timer.start()

func stop() -> void:
	timer.stop()
