extends Node

@onready var world: World
@onready var player: Player

var chaos_value: int = 1
var debug_is_enabled: bool = false

class AnimationsNames:
	static var death: String = "death"
	static var hit: String = "hit"

enum enemy_types {
	JUNIOR,
	MIDDLE,
	SENIOR,
	TEAMLID,
}
