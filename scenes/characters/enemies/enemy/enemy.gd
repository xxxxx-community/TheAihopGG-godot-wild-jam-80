extends Character
class_name Enemy

@export var target: Character

func _ready():
	collision_shape_2d.debug_color = GlobalVars.CollisionShapeDebugColors.enemy
	health_component.health = health
	health_component.max_health = max_health
	health_component.invulnerability_time = invulnerability_time
	health_component.health_replenish_is_enabled = health_replenish_is_enabled
	health_component.invulnerability_is_enabled = invulnerability_is_enabled
	health_label.visible = show_health_label
	name_label.visible = show_name_label
	speed_label.visible = show_speed_label

func _process(delta):
	move_direction = (target.global_position - global_position).normalized()
	super._process(delta)
