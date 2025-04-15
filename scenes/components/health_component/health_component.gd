extends Component
class_name HealthComponent

@export var health: int
@export var max_health: int
@export var invulnerability_time: float
@export var health_replenish_is_enabled: bool = true
@export var invulnerability_is_enabled: bool = false

@onready var invulnerability_timer: Timer = get_node("%InvulnerabilityTimer")

var temporary_invulnerability_is_enabled: bool = false

signal health_reduced(old_health: int, new_health: int)
signal damage_took(damage_count: int)
signal health_replenished(health_count: int)
signal died()

func _ready():
	assert(max_health >= health)

func reduce_health(health_count: int):
	health += health_count
	if health > max_health:
		health = max_health
	elif health <= 0:
		died.emit()
		if GlobalVars.AnimationsNames.death in parent.animation_player.get_animation_list():
			parent.animation_player.play(GlobalVars.AnimationsNames.death)
		else:
			parent.queue_free()
	health_reduced.emit(health - health_count, health)

func _take_damage(damage_count: int):
	if not temporary_invulnerability_is_enabled and not invulnerability_is_enabled:
		reduce_health(-damage_count)
		damage_took.emit(damage_count)
		temporary_invulnerability_is_enabled = true
		invulnerability_timer.start(invulnerability_time)

func _replenish_health(health_count: int):
	if health_replenish_is_enabled:
		reduce_health(health_count)
		health_replenished.emit(health_count)

func _on_invulnerability_timer_timeout() -> void:
	temporary_invulnerability_is_enabled = false
