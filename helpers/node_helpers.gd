extends Node

class_name NodeHelpers

# FIXME
# Move to another Helper !
const invalid_vector:Vector3 = Vector3(NAN, NAN, NAN)
const invalid_quaternion:Quaternion = Quaternion(NAN, NAN, NAN, NAN)

static func float_array_to_vector3(array:PackedFloat64Array):
	var ret:Vector3 = Vector3.ZERO
	var n_components:int = min(len(array), 3)
	for i in range(0, n_components):
		ret[i] = array[i]
	return ret

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
