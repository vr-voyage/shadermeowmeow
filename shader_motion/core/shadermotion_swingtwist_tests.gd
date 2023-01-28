extends Control

@export_file var results_json_filepath: String


class UnityTransform:
	var position: Vector3 = Vector3.ZERO
	var rotation: Quaternion = Quaternion.IDENTITY
	var scale: Vector3 = Vector3.ONE
	var name: String = ""
	var parent_name: String = ""


const method_analysis_json_format: Dictionary = {
	"@type": TYPE_STRING, "version": TYPE_FLOAT, "name": TYPE_STRING, "state": TYPE_DICTIONARY, "execution": TYPE_ARRAY
}

var json_object_parsers: Dictionary = {
	"Unity.Transform": _parse_json_transform,
	"Unity.Vector3": _parse_json_vector3,
	"Unity.Quaternion": _parse_json_quaternion,
	"ShaderMotion.HumanAxes": _parse_shadermotion_humanaxes
}

const invalid_quaternion: Quaternion = Quaternion(NAN, NAN, NAN, NAN)
const invalid_vector3: Vector3 = Vector3(NAN, NAN, NAN)


func _parse_json_object(json_object: Dictionary):
	var invalid_value: Object = null
	if not json_object.has("@type"):
		printerr("Unknown object type")
		return invalid_value

	var object_type: String = json_object["@type"] as String
	if object_type == null:
		printerr("Invalid object type (@type is not a String !)")
		return invalid_value

	if not json_object_parsers.has(object_type):
		printerr('Don\'t know how to parse "%s" JSON objects !' % [object_type])
		return invalid_value

	return json_object_parsers[object_type].call(json_object)


func _parse_json_array(parsed_array: Array):
	var ret: Array = []
	for element in parsed_array:
		ret.append(_parse_json_data(element))
	return ret


func _parse_json_data(json_data):
	match typeof(json_data):
		TYPE_FLOAT, TYPE_NIL:
			return json_data
		TYPE_STRING:
			match json_data:
				# Ugh...
				"@NaN":
					return NAN
				"@Infinity":
					return INF
				"@-Infinity":
					return -INF
				_:
					return json_data
		TYPE_ARRAY:
			return _parse_json_array(json_data)
		TYPE_DICTIONARY:
			return _parse_json_object(json_data)
		_:
			printerr("Don't know how to deal with content of type : %d (%s)" % [typeof(json_data), str(json_data)])
			return null


func _parse_json_vector3(json_object: Dictionary) -> Vector3:
	var invalid_value: Vector3 = invalid_vector3

	if not json_object.has("value"):
		printerr("Invalid JSON Vector3 object !")
		return invalid_value

	var values: Array = json_object["value"] as Array
	if len(values) != 3:
		printerr("Invalid JSON Vector3 values !")
		return invalid_value

	return Vector3(values[0], values[1], values[2])


func _parse_json_quaternion(json_object: Dictionary) -> Quaternion:
	var invalid_value: Quaternion = invalid_quaternion

	if not json_object.has("value"):
		printerr("Invalid JSON Quaternion object")
		return invalid_value

	var values: Array = json_object["value"] as Array
	if len(values) != 4:
		printerr("Invalid JSON Quaternion values !")
		return invalid_value

	return Quaternion(values[0], values[1], values[2], values[3])


func _any_is_null(variables: Array) -> bool:
	for variable in variables:
		if variable == null:
			return true
	return false


func _any_is_invalid(variables: Array) -> bool:
	for variable in variables:
		match typeof(variable):
			TYPE_QUATERNION:
				if variable == invalid_quaternion:
					return true
			TYPE_VECTOR3:
				if variable == invalid_vector3:
					return true
			_:
				if variable == null:
					return true
	return false


func _parse_json_transform(json_object: Dictionary) -> UnityTransform:
	var invalid_value: UnityTransform = null

	if not json_object.has_all(["position", "rotation", "scale", "name", "parent_name"]):
		printerr("Invalid JSON Unity.Transform object")
		return invalid_value

	var position_data: Dictionary = json_object["position"] as Dictionary
	var rotation_data: Dictionary = json_object["rotation"] as Dictionary
	var scale_data: Dictionary = json_object["scale"] as Dictionary

	if position_data == null or rotation_data == null or scale_data == null:
		printerr("Invalid position, rotation or scale data in this object : %s" % str(json_object))
		return invalid_value

	var unity_transform: UnityTransform = UnityTransform.new()
	unity_transform.position = _parse_json_object(position_data)
	unity_transform.rotation = _parse_json_object(rotation_data)
	unity_transform.scale = _parse_json_object(scale_data)

	return unity_transform


func _parse_shadermotion_humanaxes(json_object: Dictionary) -> Dictionary:
	var invalid_value: Dictionary = {}

	if not json_object.has_all(["preQ", "postQ", "sign"]):
		printerr("Invalid ShaderMotion.HumanAxes object")
		return invalid_value

	var pre_rotation_data: Dictionary = json_object["preQ"] as Dictionary
	var post_rotation_data: Dictionary = json_object["postQ"] as Dictionary
	var limit_sign_data: Dictionary = json_object["sign"] as Dictionary

	if _any_is_null([pre_rotation_data, post_rotation_data, limit_sign_data]):
		printerr("Malformed ShaderMotion.HumanAxes object")
		return invalid_value

	var pre_rotation: Quaternion = _parse_json_object(pre_rotation_data)
	var post_rotation: Quaternion = _parse_json_object(post_rotation_data)
	var limit_sign: Vector3 = _parse_json_object(limit_sign_data)

	if _any_is_invalid([pre_rotation, post_rotation, limit_sign]):
		printerr("Invalid data in this ShaderMotion.HumaAxes object")
		return invalid_value

	return {"pre_rotation": pre_rotation, "post_rotation": post_rotation, "limit_sign": limit_sign}


func _is_method_analysis(parsed_json: Dictionary) -> bool:
	var valid_json: bool = parsed_json.has_all(method_analysis_json_format.keys())
	if not valid_json:
		return false
	for key in method_analysis_json_format:
		var expected_type: int = method_analysis_json_format[key]
		var actual_field_type: int = typeof(parsed_json[key])
		if expected_type != actual_field_type:
			return false
	return parsed_json["@type"] == "@MethodAnalysis" and parsed_json["version"] == 1


func _method_analysis_io_content(io_object: Dictionary):
	return _parse_json_data(io_object["content"])


func _method_analysis_io_get(inputs_outputs: Dictionary, value_name: String, io_type: String):
	var returned_value = null

	if not inputs_outputs.has(io_type):
		printerr("Invalid MethodInputOutput object !")
		return returned_value

	var io_category = inputs_outputs[io_type] as Array
	if io_category == null:
		printerr("This MethodInputOutput '%s' field is invalid" % [io_type])
		return returned_value

	if io_category.is_empty():
		return returned_value

	for value in io_category:
		var value_description: Dictionary = value as Dictionary
		if value_description == null:
			printerr("Expected a Dictionary in '%s'. Got : %s" % [io_type, str(value)])
			continue

		if not value_description.has_all(["name", "content"]):
			printerr("Invalid %s data : %s" % [io_type, str(value_description)])
			continue

		if value_description["name"] != value_name:
			continue

		returned_value = _method_analysis_io_content(value_description)
		break

	return returned_value


func _method_analysis_get_input(inputs_outputs: Dictionary, input_name: String):
	return _method_analysis_io_get(inputs_outputs, input_name, "input")


func _method_analysis_get_output(inputs_outputs: Dictionary, output_name):
	return _method_analysis_io_get(inputs_outputs, output_name, "output")


# Called when the node enters the scene tree for the first time.
func _ready():
	var stopped: bool = NodeHelpers.stop_if_any_is_null(self, [results_json_filepath], "TestShaderMotionSwingTwists")
	if stopped:
		return

	var parsed_json: Dictionary = JSON.parse_string(FileAccess.get_file_as_string(results_json_filepath))
	if parsed_json == null:
		printerr("Could not parse JSON data")
		return

	if not _is_method_analysis(parsed_json):
		printerr("%s is not a MethodAnalysis JSON file." % results_json_filepath)
		return

	var human_axes = _parse_json_data(parsed_json["state"]["before"][0]["content"])

	for io_data in parsed_json["execution"]:
		var scaled_swing_twist: Vector3 = _method_analysis_get_input(io_data, "scaledSwingTwist") as Vector3
		var expected_rotation: Quaternion = _method_analysis_get_output(io_data, "rotation") as Quaternion
		#printerr(scaled_swing_twist)

		var our_rotation: Quaternion = ShaderMotionHelpers.swing_twist(scaled_swing_twist)
		var result: bool = expected_rotation.is_equal_approx(our_rotation)
		if result == false:
			printerr("Expected %s, Got %s" % [expected_rotation, our_rotation])
			return
	print("Success !")
	var bones_names = ShaderMotionHelpers.MecanimBodyBone.keys()
	var axes_records = PackedStringArray()
	var current_record_data = PackedStringArray()
	for bone in range(0, int(ShaderMotionHelpers.MecanimBodyBone.LastBone)):
		current_record_data.clear()
		var bone_name = bones_names[bone]
		var human_axe = human_axes[bone]
		for field in human_axe:
			var field_data = human_axe[field]
			var type_name = "Quaternion" if typeof(field_data) == TYPE_QUATERNION else "Vector3"
			current_record_data.append('\t\t"%s": %s%s' % [field, type_name, str(field_data)])
		axes_records.append("\tMecanimBodyBone.%s: {\n%s\n\t}" % [bone_name, ",\n".join(current_record_data)])
	print("{\n%s\n}" % [",\n".join(axes_records)])

	#print(human_axes)
	process_mode = Node.PROCESS_MODE_DISABLED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
