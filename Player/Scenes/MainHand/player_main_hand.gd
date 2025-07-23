class_name PlayerMainHand extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hold_position: Node2D = $HoldPosition
@onready var main_hand_state_machine: Node2D = $MainHandStateMachine

signal pull_string
var hand_direction: Vector2

var shoot: bool

func _ready() -> void:
	main_hand_state_machine.Initialize(self)
	pass
	
func _process(delta: float) -> void:
	calculate_direction_to_cursor()
	set_hand_direction()
	pass
	
func calculate_direction_to_cursor() -> void:
	var mouse_pos = get_global_mouse_position()
	var player_pos = global_position
	hand_direction = Vector2(mouse_pos[0] - player_pos[0],
	 mouse_pos[1] - player_pos[1])
	#if mouse_pos.x > player_pos.x + 4:
		#player.update_direction(false)
	#elif mouse_pos.x < player_pos.x - 4:
		#player.update_direction(true)

func set_hand_direction() -> void:
	rotation = hand_direction.angle() - PI/2
	
func aim()->void:
	pass

func pull_animation() -> void:
	animation_player.play("Pull")
	await animation_player.animation_finished
	animation_player.play("Max_Pull")
	pass
	
func stop_animation() -> void:
	animation_player.stop()
	animation_player.play("RESET")

func where_to_hold_string() -> Vector2:
	return hold_position.global_position
