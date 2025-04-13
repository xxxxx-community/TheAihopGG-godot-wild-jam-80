extends Character
class_name Enemy

@export var target: Character

@onready var attack_area: Area2D = get_node("%AttackArea")

func _ready():
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


func _on_attack_area_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
