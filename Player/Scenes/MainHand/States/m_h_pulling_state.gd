class_name PullingMainHandState extends MainHandState
@onready var max_pull: MaxPullMainHandState = $"../MaxPull"
@onready var idle: IdleMainHandState = $"../Idle"

var init_animation_speed: float = 1
var finished_pulling: bool = false

# store a refernece to the player this belongs to
func init() -> void:
	entity.animation_player.animation_finished.connect(finished)
	pass
	
func _ready() -> void:
	pass

#what happens when the player enters this state
func Enter() -> void:
	entity.shot_power = 0
	Input.set_custom_mouse_cursor(load("res://PlayGround/Sprites/AimCursor32.png"))
	entity.animation_player.speed_scale = GlobalPlayer.get_pull_speed()
	finished_pulling = false
	entity.animation_player.play("Pull")
	pass
	
#what happens when the player exits this state
func Exit() -> void:
	entity.animation_player.speed_scale = init_animation_speed
	pass
	
#what happens during process update in this state
func Process(_delta: float) -> MainHandState:
	entity.shot_power += _delta
	if GlobalPlayer.current_speed > GlobalPlayer.stats.min_move_shoot_spd:
		GlobalPlayer.current_speed -= _delta/2
	if !entity.pulling:
		return idle
	if finished_pulling:
		return max_pull
	return null
	
#what happens during _physics_process update in this state
func Physics(_delta: float) -> MainHandState:
	GlobalPlayer.shot_zoom(_delta*GlobalPlayer.get_pull_speed(), true,6,5)
	return null
	
#what happens during input events in this state
func HandleInput(_event: InputEvent) -> MainHandState:
	return null
	
func finished(_animation_name) -> void:
	if _animation_name == 'Pull':
		finished_pulling = true
