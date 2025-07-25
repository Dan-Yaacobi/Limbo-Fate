class_name IdleMainHandState extends MainHandState
@onready var pulling: PullingMainHandState = $"../Pulling"

# store a refernece to the player this belongs to
func init() -> void:
	pass
	
func _ready() -> void:
	pass

#what happens when the player enters this state
func Enter() -> void:
	Input.set_custom_mouse_cursor(null)
	entity.rotation = 0
	entity.animation_player.stop()
	entity.animation_player.play("Idle")
	GlobalPlayer.current_speed = 1
	pass
	
#what happens when the player exits this state
func Exit() -> void:
	pass
	
#what happens during process update in this state
func Process(_delta: float) -> MainHandState:
	if entity.pulling:
		return pulling
	return null
	
#what happens during _physics_process update in this state
func Physics(_delta: float) -> MainHandState:
	GlobalPlayer.shot_zoom(_delta*3, false,6,5)
	return null
	
#what happens during input events in this state
func HandleInput(_event: InputEvent) -> MainHandState:
	return null
	
	
