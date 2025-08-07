class_name PlayerMainHand extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hold_position: Node2D = $HoldPosition
@onready var main_hand_state_machine: Node2D = $MainHandStateMachine
@onready var max_pull_state: MaxPullMainHandState = $MainHandStateMachine/MaxPull
@onready var arrow_position: Node2D = $ArrowPosition
@onready var sprite: Sprite2D = $Sprite2D

@export var arrow: PackedScene
@export var min_shot_power: float = 0.5
@export var max_offset: float

var current_arrow: Arrow = null
var hand_direction: Vector2
var pulling: bool = false
var shot_power: float
var off_hand: PlayerOffHand
var shot_offset: float = 0

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

func set_swing_direction(_side: bool) -> void:
	if _side:
		if scale.x > 0:
			scale.x *= -1
	else:
		if scale.x < 0:
			scale.x *= -1

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
		set_offset(max_pull_state.hold_time)
		release_arrow()

func release_arrow() -> void:
	if shot_power * GlobalPlayer.get_pull_speed() >= min_shot_power:
		var direction = calc_offset_direction(hand_direction,shot_offset).normalized()
		
		current_arrow.velocity = calc_shot_velocity(shot_power,direction)
		
		current_arrow.fired = true
		current_arrow.set_dmg_modifier(shot_power)
		current_arrow.arrow_shot()
		current_arrow.reparent(get_tree().root)

	else:
		current_arrow.free()
	current_arrow = null

func calc_shot_velocity(_shot_power,direction) -> Vector2:
	return _shot_power * direction * GlobalPlayer.get_strength_shot_modifier()


func set_offset(amount: float) -> void:
	shot_offset = amount * 5
	
func calc_offset_direction(og_direction: Vector2, offset: float) -> Vector2:
	var res: Vector2
	var rand_dir: int = [1,-1].pick_random()
	if abs(og_direction.x) > abs(og_direction.y):
		res = Vector2(og_direction.x, og_direction.y + rand_dir * offset)
	else:
		res = Vector2(og_direction.x + rand_dir * offset, og_direction.y)
	return res
