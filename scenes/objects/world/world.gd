extends Node2D
class_name World

@export var world_size: Vector2 = Vector2(100.0, 100.0)

@onready var borders: Array[Node] = get_node("%Borders").get_children()

func _ready():
	GlobalVars.world = self
	for border in borders:
		border._configure_border()
