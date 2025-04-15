extends Enemy

@onready var navigation_agent: NavigationAgent2D = get_node("%NavigationAgent2D")

var next_path_position: Vector2

func _ready():
	super._ready()
	navigation_agent.debug_enabled = GlobalVars.debug_is_enabled

func _process(delta):
	navigation_agent.target_position = target.global_position
	next_path_position = navigation_agent.get_next_path_position()
	if global_position.distance_to(next_path_position) > 5:
		move_direction = (next_path_position - global_position).normalized()
	else:
		move_direction = Vector2.ZERO

	super._process(delta)
