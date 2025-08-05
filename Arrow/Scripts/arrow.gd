class_name Arrow extends CharacterBody2D

@onready var hurt_box: HurtBox = $HurtBox
@onready var sprite_2d: Sprite2D = $Sprite2D
@export var stats: ArrowStats

var fired: bool = false

func _ready() -> void:
	hurt_box.monitoring = false
	pass

func _process(_delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	#apply_friction(delta)
	if fired:
		rotate_arrow(velocity.angle() + PI)
		
	move_and_slide()
	
func apply_gravity(_delta) -> void:
	if velocity.y < 100:
		velocity.y += _delta * stats.weight

func apply_friction(_delta) -> void:
	if velocity.length() > 0:
		velocity -= velocity*_delta*stats.weight
	pass

func hit_target(_target) -> void:
	pass

func rotate_arrow(angle: float) -> void:
	rotation = angle
	pass

func arrow_shot() -> void:
	hurt_box.monitoring = true
