class_name Arrow extends CharacterBody2D

@onready var trail_particles: CPUParticles2D = $TrailParticles
@onready var hurt_box: HurtBox = $HurtBox
@onready var sprite_2d: Sprite2D = $Sprite2D
@export var stats: ArrowStats

var fired: bool = false
var perfect_shot: bool = false
var shot_power_mod: float = 0

func _ready() -> void:
	trail_particles.visible = false
	hurt_box.monitoring = false
	stats.set_arrow(self)
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
	trail_particles.visible = true
	hurt_box.monitoring = true
	
func calc_dmg() -> void:
	hurt_box.damage = floor((GlobalPlayer.get_strength() + stats.base_dmg)
	 * stats.dmg_modifier * shot_power_mod)

	
func set_dmg_modifier(_dmg_mod) -> void:
	stats.dmg_modifier += _dmg_mod
	
func set_shot_power_mod(_shot_power: float) -> void:
	shot_power_mod = pow(_shot_power, 2)
	
func set_ability(abilities: Array[ArrowAbility]) -> void:
	if abilities:
		stats.abilities = abilities
		
func apply_ability(_enemy: Enemy) -> void:
	if stats.abilities and _enemy:
		for ability in stats.abilities:
			if ability:
				ability.activate_ability(_enemy, self)

func check_perfect(hit_enemy: bool = false) -> void:
	GlobalPlayer.set_perfect_shots(perfect_shot and hit_enemy)

func clear_arrow() -> void:
	queue_free()

func shot_missed() -> void:
	GlobalPlayer.set_perfect_shots(false)

func arrow_hit_resolve(_enemy: Enemy) -> void:
	if _enemy:
		check_perfect(true)
		apply_ability(_enemy)
		calc_dmg()
		clear_arrow()

func set_dmg_color(_color: Color) -> void:
	if _color:
		hurt_box.combat_text_color = _color

func set_hit_effect_color(_color: Color) -> void:
	hurt_box.effect_color = _color
