extends VBoxContainer

@export var block_name_label:Label
@export var block_range_label:Label
@export var block_value_label:Label
@export var block_decoded_angle_label:Label
@export var block_rotation_label:Label


@export var slot_analyzer_prefab:PackedScene

@export var slots_container:Container

func _join_array(array:Array, separator:String):
	var values_string:PackedStringArray = PackedStringArray()
	for value in array:
		values_string.append(str(value))
	return separator.join(values_string)

func _float_array_to_vector3(array:PackedFloat64Array):
	var ret:Vector3 = Vector3.ZERO
	var n_components:int = min(len(array), 3)
	for i in range(0, n_components):
		ret[i] = array[i]
	return ret

func show_shader_motion_block(pixels:SpriteFrames, block_name:String, block_range:Array, use_swing_twist:bool):
	if pixels == null or block_range == null:
		printerr("%s [ShaderMotion Slots Analyzer] Passed null data to show_shadermotion_block" % name)
		return

	var n_slots = pixels.get_frame_count("default") / 2
	for slot_index in block_range:
		if slot_index >= n_slots:
			printerr(
				"%s [ShaderMotion Slots Analyzer] Only %d slots available, but asking for slot index %d"
				% [name, n_slots, slot_index])
			return

	NodeHelpers.remove_children_from(slots_container)
	var shader_motion_values:PackedFloat64Array = PackedFloat64Array()
	var shader_motion_decoded_angles:PackedFloat64Array = PackedFloat64Array()
	block_name_label.text = block_name
	block_range_label.text = "[%s]" % _join_array(block_range, ",")
	for slot_index in block_range:
		var slot_analyzer_node = slot_analyzer_prefab.instantiate()
		add_child(slot_analyzer_node)
		slot_analyzer_node.show_slot(pixels, slot_index)
		shader_motion_values.append(slot_analyzer_node.shader_motion_value)
		shader_motion_decoded_angles.append(slot_analyzer_node.shader_motion_decoded_angle)
	block_value_label.text = "(%s)" % _join_array(shader_motion_values, ", ")
	block_decoded_angle_label.text = "(%s)" % _join_array(shader_motion_decoded_angles, ", ")
	block_rotation_label.visible = use_swing_twist
	if use_swing_twist:
		# FIXME
		# This should not be done there
		var block_rotation:Quaternion = ShaderMotionHelpers.swing_twist(
			_float_array_to_vector3(shader_motion_decoded_angles)
		)
		block_rotation_label.text = "Quaternion(%s)" % block_rotation

# Called when the node enters the scene tree for the first time.
func _ready():
	var required_variables = [
		block_name_label,
		block_range_label,
		block_value_label,
		block_decoded_angle_label,
		slot_analyzer_prefab,
		slots_container
	]
	for required_variable in required_variables:
		if required_variable == null:
			printerr("%s [ShaderMotion Slots Analyzer] Script not setup correctly" % name)
			printerr("%s [ShaderMotion Slots Analyzer] Disabling" % name)
			process_mode = Node.PROCESS_MODE_DISABLED
			return


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
