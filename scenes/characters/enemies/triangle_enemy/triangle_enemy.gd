extends Enemy

func _process(delta):
	move_direction = (target.global_position - global_position).normalized()
	super._process(delta)
