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
var direction_side: bool = false # right = false, left = true
var time_before_shot_zoom: float = 0.5
var direction: float
var current_speed: float = 1
var current_jumps: int = 0
var gravity_applied: bool = true

var shooting: bool = false

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
	#if zoom_in:
		#if camera_2d.zoom.x < max_zoom:
			#camera_2d.zoom += Vector2(speed,speed)
	#else:
		#if camera_2d.zoom.x > min_zoom:
			#camera_2d.zoom -= Vector2(speed*5,speed*5)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Jump",true):
		jump()

func swing() -> void:
	pass


func update_direction(_new_side: bool) -> void:
	if _new_side != direction_side:
		direction_side = _new_side
		body.change_direction(_new_side)
		main_hand.change_direction()
		off_hand_shoulder.position.x *= -1
		off_hand.position = off_hand_shoulder.position
	
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


############# JUMP METHODS #############
func reset_jumps(_var1) -> void:
	current_jumps = stats.total_jumps
	body.animation_player.play("Idle")
	
func jump() -> void:
	if current_jumps > 0:
		var total_jump_power = stats.jump_power + get_agility()
		body.animation_player.play("Jump")
		current_jumps -= 1
		velocity.y = 0
		velocity.y -= total_jump_power / jump_handicap()

func jump_handicap() -> float:
	if shooting:
		return 1.2
	return 1


############# GRAVITY METHODS #############
func apply_gravity(_delta) -> void:
	if velocity.y < 100:
		velocity.y += _delta*stats.gravity

func gravity_off() -> void:
	gravity_applied = false

func gravity_on() -> void:
	gravity_applied = true


############# IS METHODS #############
func is_idle() -> bool:
	return player_state_machine.curr_state is IdleState
	
func is_prev_jump() -> bool:
	return player_state_machine.prev_state is AirState

func is_dash() -> bool:
	return player_state_machine.curr_state is DashState


############# GET METHODS #############
func get_strength() -> int:
	return stats.strength
	
func get_agility() -> int:
	return stats.agility

func get_pull_speed() -> float:
	return stats.pull_speed + get_strength()*0.01

func get_strength_shot_modifier() -> float:
	return get_strength() * 5 + stats.basic_shot_power


############# SET METHODS #############
func set_shooting(_val: bool) -> void:
	shooting = _val
