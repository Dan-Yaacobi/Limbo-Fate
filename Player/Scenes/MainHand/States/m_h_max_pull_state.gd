class_name MaxPullMainHandState extends MainHandState

@onready var idle: IdleMainHandState = $"../Idle"
@onready var tired_timer: Timer = $TiredTimer
@export var basic_hold_time: float = 0.5
@onready var perfect_aim_particles: CPUParticles2D = $"../../PerfectAimParticles"

var hold_time: float = 0

signal max_pull


# store a refernece to the player this belongs to
func init() -> void:
	pass
	
func _ready() -> void:
	pass

#what happens when the player enters this state
func Enter() -> void:
	perfect_aim_particles.rotation = entity.rotation
	perfect_aim_particles.emitting = true
	hold_time = 0
	max_pull.emit()
	entity.animation_player.play("Max_Pull")
	pass
	
#what happens when the player exits this state
func Exit() -> void:
	hold_time = 0
	
#what happens during process update in this state
func Process(_delta: float) -> MainHandState:
	hold_time += _delta
	if !entity.pulling:
		return idle
	return null
	
#what happens during _physics_process update in this state
func Physics(_delta: float) -> MainHandState:
	return null
	
#what happens during input events in this state
func HandleInput(_event: InputEvent) -> MainHandState:
	return null
