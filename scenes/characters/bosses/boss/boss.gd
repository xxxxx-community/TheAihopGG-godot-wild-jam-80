extends Enemy
class_name Boss

@export var is_final: bool = false

func _on_health_component_died() -> void:
	if is_final:
		pass
		# TODO: add end game
