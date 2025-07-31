class_name Player extends CharacterBody2D

@onready var main_hand: PlayerMainHand = $PlayerMainHand
@onready var off_hand_shoulder: Node2D = $OffHandShoulder
@onready var off_hand: Node2D = $PlayerOffHand
@onready var camera_2d: Camera2D = $Camera2D
@onready var player_state_machine: PlayerStateMachine = $PlayerStateMachine
@onready var body: PlayerBody = $PlayerBody
@onready var jump_reset: Area2D = $JumpReset

@export var stats: PlayerStats

var zooming: bool
var direction_side: bool = false
var time_before_shot_zoom: float = 0.5
var shooting: bool = false
var direction: float
var current_speed: float = 1
var current_jumps: int = 0
var gravity_applied: bool = true
var shot_failed_flag: bool = false

func _ready() -> void:
	player_state_machine.Initialize(self)
	off_hand.connect_hands(main_hand, off_hand_shoulder)
	main_hand.connect_hands(off_hand)
	jump_reset.body_entered.connect(reset_jumps) #change this to body_shape_entered when moving to tiles!!!!!!!!!!!!!!!
	
func _process(_delta: float) -> void:
	direction = Input.get_axis("Left","Right")
	
func _physics_process(delta: float) -> void:
	if not is_dash():
		var speed = stats.move_speed + get_agility()
		velocity.x = speed * direction * current_speed
	if gravity_applied:
		apply_gravity(delta)
	move_and_slide()
	
func shot_zoom(speed: float ,zoom_in: bool,max_zoom: float, min_zoom: float) -> void:
	return
	if zoom_in:
		if camera_2d.zoom.x < max_zoom:
			camera_2d.zoom += Vector2(speed,speed)
	else:
		if camera_2d.zoom.x > min_zoom:
			camera_2d.zoom -= Vector2(speed*5,speed*5)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Jump",true):
		jump()
		
	if event.is_action_pressed("Shoot",true):
		shot_failed_flag = false
		shooting = true
		change_pulling()
		
		await get_tree().create_timer(time_before_shot_zoom).timeout
		if event.is_action("Shoot"):
			zooming = true
			
	elif event.is_action_released("Shoot",true) and not shot_failed_flag:
		change_pulling()
		zooming = false
		shoot()

func shoot() -> void:
	shooting = false
	pass

func reset_jumps(_var1) -> void:
	current_jumps = stats.total_jumps
	body.animation_player.play("Idle")
	
func jump() -> void:
	if current_jumps > 0:
		var total_jump_power = stats.jump_power + get_agility()
		body.animation_player.play("Jump")
		current_jumps -= 1
		velocity.y = 0
		var jump_shoot_handicap: float = 1
		if shooting:
			jump_shoot_handicap = 1.2
		velocity.y -= total_jump_power / jump_shoot_handicap
	
func apply_gravity(_delta) -> void:
	if velocity.y < 100:
		velocity.y += _delta*stats.gravity
		
func update_direction(_new_side: bool) -> void:

	if _new_side != direction_side:
		direction_side = _new_side
		body.change_direction(_new_side)
		main_hand.change_direction()
		off_hand_shoulder.position.x *= -1
		off_hand.position = off_hand_shoulder.position

func player_state() -> PlayerState:
	return player_state_machine.curr_state

func is_idle() -> bool:
	return player_state_machine.curr_state is IdleState
	
func is_prev_jump() -> bool:
	return player_state_machine.prev_state is AirState

func is_dash() -> bool:
	return player_state_machine.curr_state is DashState

func gravity_off() -> void:
	gravity_applied = false

func gravity_on() -> void:
	gravity_applied = true
	
func apply_knockback(base_force: Vector2) -> void:
	main_hand.pulling = false
	velocity = Vector2.ZERO
	velocity += base_force * (1.0 - stats.knockback_resistance)

func apply_invincibility() -> void:
	pass
	
func take_hit(amount: int = 0, knockback_power: Vector2 = Vector2.ZERO) -> void:
	apply_knockback(knockback_power)
	apply_invincibility()
	stats.current_hp -= amount
	if stats.current_hp <= 0:
		print("dead")
	pass

func change_pulling() -> void:
	off_hand.change_shooting()
	main_hand.change_pulling()

func shot_failed() -> void:
	shot_failed_flag = true
	shooting = false
	
func get_strength() -> int:
	return stats.strength
	
func get_agility() -> int:
	return stats.agility

func get_pull_speed() -> float:
	return stats.pull_speed + get_strength()*0.01
