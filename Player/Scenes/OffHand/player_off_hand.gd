class_name PlayerOffHand extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var off_hand_state_machine: OffHandStateMachine = $OffHandStateMachine

var main_hand: PlayerMainHand
var shooting: bool = false
var shoulder: Node2D

func _ready() -> void:
	off_hand_state_machine.Initialize(self)
	pass

func connect_hands(_main_hand: PlayerMainHand) -> void:
	main_hand = _main_hand
	
func _process(delta: float) -> void:
	print(rotation)
	pass
