class_name MaxPullMainHandState extends MainHandState

@onready var idle: IdleMainHandState = $"../Idle"
@onready var tired_timer: Timer = $TiredTimer
@export var basic_hold_time: float = 0.5
signal max_pull
# store a refernece to the player this belongs to
func init() -> void:
	tired_timer.timeout.connect(drop_arrow_fatigued)
	pass
	
func _ready() -> void:
	tired_timer.wait_time = calculate_hold_time()
	pass

#what happens when the player enters this state
func Enter() -> void:
	tired_timer.start()
	max_pull.emit()
	entity.animation_player.play("Max_Pull")
	pass
	
#what happens when the player exits this state
func Exit() -> void:
	tired_timer.stop()
	pass
	
#what happens during process update in this state
func Process(_delta: float) -> MainHandState:
	if !entity.pulling:
		return idle
	return null
	
#what happens during _physics_process update in this state
func Physics(_delta: float) -> MainHandState:
	return null
	
#what happens during input events in this state
func HandleInput(_event: InputEvent) -> MainHandState:
	return null
	
func drop_arrow_fatigued() -> void:
	entity.shot_power = 0
	GlobalPlayer.change_pulling()
	GlobalPlayer.shot_failed()

func calculate_hold_time() -> float:
	return basic_hold_time + GlobalPlayer.get_strength()*0.1
