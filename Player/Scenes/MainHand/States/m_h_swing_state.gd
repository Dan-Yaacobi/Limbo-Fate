class_name SwingMainHandState extends MainHandState

@onready var idle: IdleMainHandState = $"../Idle"
@onready var slash_animation_player: AnimationPlayer = $SlashEffect/SlashAnimationPlayer
@onready var slash_hurt_box: HurtBox = $"../../SlashHurtBox"
@onready var swing_cooldown: Timer = $"../SwingCooldown"

var finished: bool = false

# store a refernece to the player this belongs to
func init() -> void:
	entity.animation_player.animation_finished.connect(swing_done)
	slash_hurt_box.monitoring = false
	pass
	
func _ready() -> void:
	pass

#what happens when the player enters this state
func Enter() -> void:
	entity.can_swing = false
	finished = false
	slash_hurt_box.damage = floor(GlobalPlayer.get_strength()/2)
	slash_animation_player.play("SlashEffect")
	set_direction()
	entity.animation_player.play("Swing")
	slash_hurt_box.monitoring = true
	pass
	
#what happens when the player exits this state
func Exit() -> void:
	slash_hurt_box.monitoring = false
	swing_cooldown.start()
	pass
	
#what happens during process update in this state
func Process(_delta: float) -> MainHandState:
	set_direction()
	if finished:
		return idle
	#await get_tree().create_timer(entity.animation_player.get_animation("Swing").length).timeout
	#return idle
	return null
	
#what happens during _physics_process update in this state
func Physics(_delta: float) -> MainHandState:
	return null
	
#what happens during input events in this state
func HandleInput(_event: InputEvent) -> MainHandState:
	return null

func swing_done(_anim) -> void:
	finished = true

func slash_hit_direction() -> void:
	if GlobalPlayer.direction_side:
		if slash_hurt_box.position.x > 0:
			slash_hurt_box.position.x *= -1
	else:
		if slash_hurt_box.position.x < 0:
			slash_hurt_box.position.x *= -1

	pass

func set_direction() -> void:
	slash_hit_direction()
	entity.set_swing_direction(GlobalPlayer.direction_side)
