extends Enemy

@onready var navigation_agent: NavigationAgent2D = get_node("%NavigationAgent2D")

var next_path_position: Vector2

func _ready():
	super._ready()
	navigation_agent.debug_enabled = GlobalVars.debug_is_enabled

func _process(delta):
	navigation_agent.target_position = target.global_position
	next_path_position = navigation_agent.get_next_path_position()
	move_direction = (next_path_position - global_position).normalized()

	super._process(delta)
