class_name PlayerOffHand extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var off_hand_state_machine: OffHandStateMachine = $OffHandStateMachine

var main_hand: PlayerMainHand
var shooting: bool = false
var shoulder: Node2D

func _ready() -> void:
	off_hand_state_machine.Initialize(self)
	pass
	
func _process(delta: float) -> void:
	pass
	
func connect_hands(_main_hand: PlayerMainHand, _shoulder: Node2D) -> void:
	main_hand = _main_hand
	shoulder = _shoulder

func change_shooting() -> void:
	shooting = not shooting
