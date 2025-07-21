class_name Player extends CharacterBody2D

@onready var player_off_hand: Node2D = $PlayerOffHand
@onready var camera_2d: Camera2D = $Camera2D
var zooming: bool

func _ready() -> void:
	player_off_hand.z_index = -2
	pass


func _process(delta: float) -> void:
	shot_zoom(delta,zooming)

func shot_zoom(speed: float ,zoom_in: bool) -> void:
	if zoom_in:
		if camera_2d.zoom.x < 6:
			camera_2d.zoom += Vector2(speed,speed)
	else:
		if camera_2d.zoom.x > 5:
			camera_2d.zoom -= Vector2(speed*5,speed*5)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Shoot"):
		player_off_hand.z_index = 0
		await get_tree().create_timer(0.5).timeout
		if event.is_action("Shoot"):
			zooming = true
	elif event.is_action_released("Shoot"):
		player_off_hand.z_index = -2
		zooming = false
