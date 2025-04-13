extends Bullet

func _ready():
	super._ready()
	parent.movement_is_enabled = false
	
func _on_lifetime_expired() -> void:
	parent.movement_is_enabled = true

func _on_hit(_character: Character) -> void:
	parent.movement_is_enabled = true
