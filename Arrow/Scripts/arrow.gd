class_name Arrow extends CharacterBody2D

@onready var hit_box: Area2D = $HitBox
@onready var sprite_2d: Sprite2D = $Sprite2D

var fired: bool = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	move_and_slide()
	if fired:
		rotate_arrow(velocity.angle() + PI)
	
func apply_gravity(_delta) -> void:
	if velocity.y < 100:
		velocity.y += _delta * 50

func apply_friction(_delta) -> void:
	pass

func rotate_arrow(angle: float) -> void:
	rotation = angle
	pass
