extends StaticBody2D
class_name WorldBorders

@onready var top_border: CollisionShape2D = get_node("TopBorder")
@onready var bottom_border: CollisionShape2D = get_node("BottomBorder")
@onready var right_border: CollisionShape2D = get_node("BorderRight")
@onready var left_border: CollisionShape2D = get_node("BorderLeft")

func _set_borders():
	var x_distance: float = -(GlobalVars.world.world_size.x / 2)
	var y_distance: float = -(GlobalVars.world.world_size.y / 2)
	
	top_border.shape.distance = y_distance
	bottom_border.shape.distance = y_distance
	right_border.shape.distance = x_distance
	left_border.shape.distance = x_distance
