extends Node

class_name NodeHelpers

static func remove_children_from(node:Node):
	var node_children:Array = node.get_children()
	var current_index:int = len(node_children) - 1
	while current_index >= 0:
		node.remove_child(node_children[current_index])
		current_index -= 1

static func stop_if_any_is_null(
	node:Node,
	variables_to_check:Array,
	readable_name:String
) -> bool:

	var null_found:bool = false

	for variable in variables_to_check:
		null_found = (variable == null)
		if null_found:
			printerr(
				"[%s] (%s) The component is not setup correctly. Disabling"
				% [readable_name, node.name])
			node.process_mode = Node.PROCESS_MODE_DISABLED
			break
	return null_found
