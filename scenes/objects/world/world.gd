extends Node2D
class_name World

@export var world_size: Vector2 = Vector2(100.0, 100.0)

@onready var world_borders: WorldBorders = get_node("%WorldBorders")

func _ready():
	GlobalVars.world = self
	world_borders._set_borders()
