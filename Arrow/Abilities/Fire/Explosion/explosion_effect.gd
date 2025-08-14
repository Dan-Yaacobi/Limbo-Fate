class_name ExplosionEffect extends Effect

@onready var explosion_effect: CPUParticles2D = $ExplosionEffect
@onready var hurt_box: ExplosionHurtBox = $ExplosionHurtBox

var explosion_dmg: int

func _ready() -> void:
	if get_parent() is Enemy:
		enemy = get_parent()
		explosion_effect.emitting = true
		explosion_effect.one_shot = true
		hurt_box.damage = explosion_dmg
	pass

func _process(delta: float) -> void:
	if !explosion_effect.emitting:
		explosion_ended()
		
func set_explosion(_dmg: int) -> void:
	explosion_dmg = _dmg

func explosion_ended() -> void:
	queue_free()
