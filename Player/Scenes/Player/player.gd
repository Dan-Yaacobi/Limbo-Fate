class_name Player extends CharacterBody2D

@onready var main_hand: PlayerMainHand = $PlayerMainHand
@onready var off_hand_shoulder: Node2D = $OffHandShoulder
@onready var off_hand: Node2D = $PlayerOffHand
@onready var camera_2d: Camera2D = $Camera2D
@onready var player_state_machine: PlayerStateMachine = $PlayerStateMachine

var zooming: bool

func _ready() -> void:
	player_state_machine.Initialize(self)
	off_hand.shoulder = off_hand_shoulder
	off_hand.connect_hands(main_hand)
	pass


func _process(delta: float) -> void:
	shot_zoom(delta,zooming,6,5)

func shot_zoom(speed: float ,zoom_in: bool,max_zoom: float, min_zoom: float) -> void:
	if zoom_in:
		if camera_2d.zoom.x < max_zoom:
			camera_2d.zoom += Vector2(speed,speed)
	else:
		if camera_2d.zoom.x > min_zoom:
			camera_2d.zoom -= Vector2(speed*5,speed*5)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Shoot",true):
		off_hand.shooting = true
		main_hand.pull_animation()
		await get_tree().create_timer(0.5).timeout
		
		if event.is_action("Shoot",true):
			zooming = true
			
	elif event.is_action_released("Shoot",true):
		off_hand.shooting = false
		main_hand.stop_animation()
		zooming = false
