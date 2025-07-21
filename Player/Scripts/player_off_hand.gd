class_name PlayerOffHand extends CharacterBody2D

@onready var string_line: Line2D = $Line2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hand_sprite: Sprite2D = $Sprite2D
@onready var mid_string_pos: Node2D = $MidStringPos

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func pull_string_animate() -> void:
	animation_player.play("Pull")

func stop_animation() -> void:
	animation_player.play("RESET")

func stretch_arm(stretch_amount) -> void:
	
	hand_sprite.scale.y += stretch_amount
	hand_sprite.position.y -= stretch_amount
	position.y -= stretch_amount
	pass

func strng_pos_diff() -> Vector2:
	return Vector2(0,0)
