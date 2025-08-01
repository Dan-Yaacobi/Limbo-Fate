class_name AirState extends PlayerState
@onready var walk: WalkState = $"../WalkState"
@onready var idle: IdleState = $"../IdleState"
@onready var dash: DashState = $"../DashState"

func init() -> void:
	pass
	
func _ready() -> void:
	pass

#what happens when the player enters this state
func Enter() -> void:
	entity.body.update_animation("Jump")
	pass
	
#what happens when the player exits this state
func Exit() -> void:
	pass
	
#what happens during process update in this state
func Process(_delta: float) -> PlayerState:
	if entity.is_on_floor():
		return idle
	return null
	
#what happens during _physics_process update in this state
func Physics(_delta: float) -> PlayerState:
	entity.update_direction(entity.direction < 0)
	return null
	
#what happens during input events in this state
func HandleInput(_event: InputEvent) -> PlayerState:
	if _event.is_action_pressed("Dash") and entity.stats.can_dash:
		return dash
	return null
	
	
