extends StaticBody2D
class_name WorldBorder

@export var border_normal: Vector2 = Vector2.UP

@onready var collision_shape_2d = get_node("CollisionShape2D")

func _ready():
	collision_shape_2d.shape.normal = border_normal
	if border_normal == Vector2.UP or border_normal == Vector2.DOWN:
		collision_shape_2d.shape.distance = GlobalVars.world.world_size.y / 2
	elif border_normal == Vector2.RIGHT or border_normal == Vector2.LEFT:
		collision_shape_2d.shape.distance = GlobalVars.world.world_size.x / 2
	else:
		printerr("CRITICAL: `border_normal` must be a direction")
