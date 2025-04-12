extends Character
class_name Player

@export var health: int
@export var max_health: int
@export var invulnerability_time: float
@export var health_replenish_is_enabled: bool = true
@export var invulnerability_is_enabled: bool = false # note: don t use invulnerability_is_enabled, use health_component.invulnerability_is_enabled

@onready var health_component: HealthComponent = get_node("%HealthComponent")

func _ready():
	GlobalVars.player = self
	health_component.health = health
	health_component.max_health = max_health
	health_component.invulnerability_time = invulnerability_time
	health_component.health_replenish_is_enabled = health_replenish_is_enabled
	health_component.invulnerability_is_enabled = invulnerability_is_enabled

func _process(delta: float) -> void:
	move_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	super._process(delta)
