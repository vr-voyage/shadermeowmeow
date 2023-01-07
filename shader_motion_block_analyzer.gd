extends VBoxContainer

@export var block_name_label:Label
@export var block_range_label:Label
@export var block_value_label:Label
@export var block_swing_twist_label:Label

@export var slot_analyzer_prefab:PackedScene

@export var slots_container:Container

func _join_array(array:Array, separator:String):
	var values_string:PackedStringArray = PackedStringArray()
	for value in array:
		values_string.append(str(value))
	return separator.join(values_string)

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
	var shader_motion_swing_twist_values:PackedFloat64Array = PackedFloat64Array()
	block_name_label.text = block_name
	block_range_label.text = "[%s]" % _join_array(block_range, ",")
	for slot_index in block_range:
		var slot_analyzer_node = slot_analyzer_prefab.instantiate()
		add_child(slot_analyzer_node)
		slot_analyzer_node.show_slot(pixels, slot_index)
		shader_motion_values.append(slot_analyzer_node.shader_motion_value)
		shader_motion_swing_twist_values.append(slot_analyzer_node.shader_motion_swing_twist_value)
	block_value_label.text = "(%s)" % _join_array(shader_motion_values, ", ")
	block_swing_twist_label.text = "(%s)" % _join_array(shader_motion_swing_twist_values, ", ")
	block_swing_twist_label.visible = use_swing_twist

# Called when the node enters the scene tree for the first time.
func _ready():
	var required_variables = [
		block_name_label,
		block_range_label,
		block_value_label,
		block_swing_twist_label,
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
