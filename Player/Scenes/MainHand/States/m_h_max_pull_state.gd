class_name MaxPullMainHandState extends MainHandState
@onready var idle: IdleMainHandState = $"../Idle"

signal max_pull
# store a refernece to the player this belongs to
func init() -> void:
	pass
	
func _ready() -> void:
	pass

#what happens when the player enters this state
func Enter() -> void:
	max_pull.emit()
	entity.animation_player.play("Max_Pull")
	pass
	
#what happens when the player exits this state
func Exit() -> void:
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
	
	
