extends Character
class_name Enemy

@export var target: Character
@export var collide_damage: int
@export var collide_damage_duration: float
@export var enemy_type: GlobalVars.enemy_types = GlobalVars.enemy_types.JUNIOR

@onready var collide_damage_timer = get_node("%CollideDamageTimer")
@onready var attack_area: Area2D = get_node("%AttackArea")

var total_target: Character

func is_target(body: Node2D) -> bool:
	for group in target.get_groups():
		if not body.is_in_group(group):
			return false
	return true

func _on_attack_area_body_entered(body: Node2D) -> void:
	if is_target(body):
		total_target = body
		total_target.health_component._take_damage(collide_damage)
		collide_damage_timer.start(collide_damage_duration)

func _on_collide_damage_timer_timeout() -> void:
	if total_target:
		total_target.health_component._take_damage(collide_damage)
		collide_damage_timer.start(collide_damage_duration)

func _on_attack_area_body_exited(body: Node2D) -> void:
	if is_target(body):
		total_target = null
