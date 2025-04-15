extends Node
class_name Component

@export var parent: Node = self.get_parent().get_parent() if self.get_parent() else null
