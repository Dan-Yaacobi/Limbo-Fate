class_name PlayerBody extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var eyes_sprite: Sprite2D = $Sprite2D/Eyes

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if GlobalPlayer.shooting:
		eyes_sprite.frame = 1
	else:
		eyes_sprite.frame = 0
		blink()
	pass

func change_direction(direction: bool) -> void:
	sprite.flip_h = direction
	eyes_sprite.flip_h = direction

func blink() -> void:
	var random_chance = randi_range(0,200)
	if random_chance == 0:
		eyes_sprite.frame = 3
		await get_tree().create_timer(0.3).timeout
		eyes_sprite.frame = 0
		
func update_animation(anim: String) -> void:
	animation_player.play(anim)
