class_name Arrow extends CharacterBody2D

@onready var trail_particles: CPUParticles2D = $TrailParticles
@onready var hurt_box: HurtBox = $HurtBox
@onready var sprite_2d: Sprite2D = $Sprite2D
@export var stats: ArrowStats

var fired: bool = false

func _ready() -> void:
	trail_particles.visible = false
	hurt_box.monitoring = false
	pass

func _process(_delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	#apply_friction(delta)
	if fired:
		rotate_arrow(velocity.angle() + PI)
		trail_particles.direction = velocity
	move_and_slide()
	
func apply_gravity(_delta) -> void:
	if velocity.y < 100:
		velocity.y += _delta * stats.weight

func apply_friction(_delta) -> void:
	if velocity.length() > 0:
		velocity -= velocity*_delta*stats.weight
	pass

func rotate_arrow(angle: float) -> void:
	rotation = angle
	pass

func arrow_shot() -> void:
	calc_dmg()
	trail_particles.visible = true
	hurt_box.monitoring = true
	
func calc_dmg() -> void:
	hurt_box.damage = floor((GlobalPlayer.get_strength() + stats.base_dmg) * pow(stats.dmg_modifier,3))

func set_dmg_modifier(_dmg_mod) -> void:
	stats.dmg_modifier = _dmg_mod
