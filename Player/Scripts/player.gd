class_name Player extends CharacterBody2D

@onready var main_hand: PlayerHand = $PlayerHand
@onready var off_hand: Node2D = $PlayerOffHand
@onready var camera_2d: Camera2D = $Camera2D
var zooming: bool

func _ready() -> void:
	off_hand.z_index = -2
	pass


func _process(delta: float) -> void:
	shot_zoom(delta,zooming)
	off_hand.rotation = main_hand.rotation
	off_hand.global_position = main_hand.where_to_hold_string(off_hand.strng_pos_diff())
	
func shot_zoom(speed: float ,zoom_in: bool) -> void:
	
	if zoom_in:
		if camera_2d.zoom.x < 6:
			camera_2d.zoom += Vector2(speed,speed)
	else:
		if camera_2d.zoom.x > 5:
			camera_2d.zoom -= Vector2(speed*5,speed*5)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Shoot"):
		off_hand.z_index = 0
		main_hand.pull_animation()
		off_hand.pull_string_animate()
		await get_tree().create_timer(0.5).timeout
		
		if event.is_action("Shoot"):
			zooming = true
			
	elif event.is_action_released("Shoot"):
		main_hand.stop_animation()
		off_hand.stop_animation()
		off_hand.z_index = -2
		zooming = false

	
