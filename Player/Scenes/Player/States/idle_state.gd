class_name IdleState extends PlayerState
@onready var walk: WalkState = $"../WalkState"
@onready var air: AirState = $"../AirState"

func init() -> void:
	pass
	
func _ready() -> void:
	pass

#what happens when the player enters this state
func Enter() -> void:
	await get_tree().create_timer(0.1).timeout
	if entity.direction == 0:
		entity.body.update_animation("Idle")
	pass
	
#what happens when the player exits this state
func Exit() -> void:
	pass
	
#what happens during process update in this state
func Process(_delta: float) -> PlayerState:
	if entity.direction != 0:
		return walk
	if entity.velocity.y != 0:
		return air
	return null
	
#what happens during _physics_process update in this state
func Physics(_delta: float) -> PlayerState:
	return null
	
#what happens during input events in this state
func HandleInput(_event: InputEvent) -> PlayerState:
	return null
