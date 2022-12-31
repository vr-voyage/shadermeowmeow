extends Node

static func remove_children_from(node:Node):
	var last_child = node.get_child(-1)
	while last_child != null:
		node.remove_child(last_child)
		last_child = node.get_child(-1)

