extends Node2D
class_name World

@export var world_size: Vector2

@onready var characters: Node = get_node("Characters")
@onready var world_borders: WorldBorders = get_node("%WorldBorders")

func _ready():
	GlobalVars.world = self
	world_borders._set_borders()
