class_name PlayerMainHand extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hold_position: Node2D = $HoldPosition
@onready var main_hand_state_machine: Node2D = $MainHandStateMachine
@onready var max_pull_state: MaxPullMainHandState = $MainHandStateMachine/MaxPull
@onready var arrow_position: Node2D = $ArrowPosition

@export var arrow: PackedScene
@export var min_shot_power: float = 0.5

var current_arrow: Arrow = null
var hand_direction: Vector2
var pulling: bool = false
var shot_power: float
var off_hand: PlayerOffHand

func _ready() -> void:
	main_hand_state_machine.Initialize(self)
	pass
	
func _process(_delta: float) -> void:
	if pulling:
		calculate_direction_to_cursor()
		set_hand_direction()
	if GlobalPlayer.is_idle() and not GlobalPlayer.is_prev_jump():
		calculate_direction_to_cursor()
	pass

func connect_hands(_off_hand) -> void:
	if _off_hand:
		off_hand = _off_hand
		
func calculate_direction_to_cursor() -> void:
	var mouse_pos = get_global_mouse_position()
	var player_pos = global_position
	hand_direction = Vector2(mouse_pos[0] - player_pos[0],
	 mouse_pos[1] - player_pos[1])

	if mouse_pos.x > player_pos.x + 4:
		GlobalPlayer.update_direction(false)
	elif mouse_pos.x < player_pos.x - 4:
		GlobalPlayer.update_direction(true)

func draw_arrow() -> void:
	if !current_arrow:
		var new_arrow: Arrow = arrow.instantiate()
		arrow_position.add_child(new_arrow)
		current_arrow = new_arrow

func set_hand_direction() -> void:
	rotation = hand_direction.angle() - PI/2
	if current_arrow:
		current_arrow.global_position = where_to_hold_arrow()
		
func where_to_hold_string() -> Vector2:
	return hold_position.global_position

func where_to_hold_arrow() -> Vector2:
	return arrow_position.global_position
	
func change_direction() -> void:
	position.x *= - 1

func change_pulling() -> void:
	pulling = not pulling
	if pulling:
		draw_arrow()
	else:
		release_arrow()

func release_arrow() -> void:
	if shot_power * GlobalPlayer.get_pull_speed() >= min_shot_power:
		current_arrow.velocity = (shot_power * hand_direction.normalized()
		 * GlobalPlayer.get_strength() + hand_direction.normalized()*GlobalPlayer.stats.basic_shot_power)
		current_arrow.fired = true
		current_arrow.reparent(current_arrow.get_parent().get_parent().get_parent().get_parent())
		
	else:
		current_arrow.free()
	current_arrow = null
