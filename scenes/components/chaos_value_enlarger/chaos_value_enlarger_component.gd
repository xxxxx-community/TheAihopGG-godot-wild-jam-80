extends Component
class_name ChaosValueEnlargerComponent

@export var enlarge_chaos_value_time: float
@export var chaos_enlarge_value: int

@onready var enlarge_chaos_value_timer: Timer = get_node("%EnlargeChaosValueTimer")

func _ready():
	enlarge_chaos_value_timer.start(enlarge_chaos_value_time)

func _on_enlarge_chaos_value_timer_timeout() -> void:
	GlobalVars.chaos_value += chaos_enlarge_value
	print(GlobalVars.chaos_value)
