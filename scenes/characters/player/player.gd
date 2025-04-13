extends Character
class_name Player

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
