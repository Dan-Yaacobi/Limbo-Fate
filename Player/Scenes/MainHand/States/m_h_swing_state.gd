class_name SwingMainHandState extends MainHandState
@onready var idle: IdleMainHandState = $"../Idle"

var finished: bool = false
# store a refernece to the player this belongs to
func init() -> void:
	entity.animation_player.animation_finished.connect(swing_done)
	pass
	
func _ready() -> void:
	pass

#what happens when the player enters this state
func Enter() -> void:
	finished = false
	entity.set_swing_direction(GlobalPlayer.direction_side)
	entity.animation_player.play("Swing")
	
	pass
	
#what happens when the player exits this state
func Exit() -> void:
	pass
	
#what happens during process update in this state
func Process(_delta: float) -> MainHandState:
	if finished:
		return idle
	#await get_tree().create_timer(entity.animation_player.get_animation("Swing").length).timeout
	#return idle
	return null
	
#what happens during _physics_process update in this state
func Physics(_delta: float) -> MainHandState:
	return null
	
#what happens during input events in this state
func HandleInput(_event: InputEvent) -> MainHandState:
	return null

func swing_done(_anim) -> void:
	finished = true
