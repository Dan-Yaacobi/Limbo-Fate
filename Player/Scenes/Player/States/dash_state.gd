class_name DashState extends PlayerState
@onready var idle: IdleState = $"../IdleState"
@onready var air: AirState = $"../AirState"
@onready var dash_timer: Timer = $DashTimer
@onready var dash_cd: Timer = $DashCD

var dash_finished: bool = false

func init() -> void:
	dash_timer.wait_time = entity.stats.dash_length.final_stat()
	dash_timer.timeout.connect(finished)
	pass
	
func _ready() -> void:
	pass

#what happens when the player enters this state
func Enter() -> void:
	dash_finished = false
	#dash_timer.wait_time += (entity.get_agility()/10)*0.1 
	dash_timer.start()
	#entity.body.update_animation("Dash")
	entity.velocity.x = 0
	entity.velocity.x = (entity.stats.dash_speed.final_stat() + entity.get_agility()) * entity.direction
	pass
	
#what happens when the player exits this state
func Exit() -> void:
	dash_timer.stop()
	pass
	
#what happens during process update in this state
func Process(_delta: float) -> PlayerState:
	if dash_finished:
		return idle
	return null
	
#what happens during _physics_process update in this state
func Physics(_delta: float) -> PlayerState:
	#entity.update_direction(entity.direction < 0)
	return null
	
#what happens during input events in this state
func HandleInput(_event: InputEvent) -> PlayerState:
	return null
	
func finished() -> void:
	dash_finished = true
