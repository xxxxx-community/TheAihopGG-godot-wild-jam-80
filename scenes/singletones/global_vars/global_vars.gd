extends Node

@onready var world: World
@onready var player: Player

class AnimationsNames:
	static var death: String = "death"

class CollisionShapeDebugColors:
	static var character: Color = Color(255, 255, 255)
	static var player: Color = Color(0, 255, 0)
	static var enemy: Color = Color(255, 0, 0)
