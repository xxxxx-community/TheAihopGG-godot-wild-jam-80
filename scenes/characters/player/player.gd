extends Character
class_name Player

func _ready():
	GlobalVars.player = self
	health_component.health = health
	health_component.max_health = max_health
	health_component.invulnerability_time = invulnerability_time
	health_component.health_replenish_is_enabled = health_replenish_is_enabled
	health_component.invulnerability_is_enabled = invulnerability_is_enabled
	health_label.visible = show_health_label
	name_label.visible = show_name_label
	speed_label.visible = show_speed_label

func _process(delta: float) -> void:
	move_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if Input.is_action_just_pressed("ui_home"):
		if show_health_label:
			show_health_label = false
		else:
			show_health_label = true
	super._process(delta)
