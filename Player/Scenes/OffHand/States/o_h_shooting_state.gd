class_name ShootingOffHandState extends OffHandState
@onready var idle: IdleOffHandState = $"../Idle"

# store a refernece to the player this belongs to
func init() -> void:
	pass
	
func _ready() -> void:
	pass

#what happens when the player enters this state
func Enter() -> void:
	entity.z_index = 0
	entity.animation_player.play("Pull")
	pass
	
#what happens when the player exits this state
func Exit() -> void:
	pass
	
#what happens during process update in this state
func Process(_delta: float) -> OffHandState:
	entity.rotation = entity.main_hand.rotation
	entity.global_position = entity.main_hand.where_to_hold_string()
	if !entity.shooting:
		return idle
	return null
	
#what happens during _physics_process update in this state
func Physics(_delta: float) -> OffHandState:
	return null
	
#what happens during input events in this state
func HandleInput(_event: InputEvent) -> OffHandState:
	return null
	
	
