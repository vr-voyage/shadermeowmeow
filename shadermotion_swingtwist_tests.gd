extends Control

@export_file var results_json_filepath:String

class UnityTransform:
	var position:Vector3 = Vector3.ZERO
	var rotation:Quaternion = Quaternion.IDENTITY
	var scale:Vector3 = Vector3.ONE
	var name:String = ""
	var parent_name:String = ""

const method_analysis_json_format:Dictionary = {
	"@type": TYPE_STRING,
	"version": TYPE_FLOAT,
	"name": TYPE_STRING,
	"state": TYPE_DICTIONARY,
	"execution": TYPE_ARRAY
}

var json_object_parsers:Dictionary = {
	"Unity.Transform": _parse_json_transform,
	"Unity.Vector3": _parse_json_vector3,
	"Unity.Quaternion": _parse_json_quaternion
}

func _parse_json_object(json_object:Dictionary):
	var invalid_value:Object = null
	if not json_object.has("@type"):
		printerr("Unknown object type")
		return invalid_value

	var object_type:String = json_object["@type"] as String
	if object_type == null:
		printerr("Invalid object type !")
		return invalid_value

	if not json_object_parsers.has(object_type):
		printerr(
			"Don't know how to parse \"%s\" JSON objects !"
			% [object_type])
		return invalid_value

	return json_object_parsers[object_type].call(json_object)

func _parse_json_vector3(json_object:Dictionary) -> Vector3:

	var invalid_value:Vector3 = Vector3(NAN, NAN, NAN)

	if not json_object.has("value"):
		printerr("Invalid JSON Vector3 object !")
		return invalid_value

	var values:Array = json_object["value"] as Array
	if len(values) !=  3:
		printerr("Invalid JSON Vector3 values !")
		return invalid_value

	return Vector3(values[0], values[1], values[2])

func _parse_json_quaternion(json_object:Dictionary) -> Quaternion:

	var invalid_value:Quaternion = Quaternion(NAN, NAN, NAN, NAN)

	if not json_object.has("value"):
		printerr("Invalid JSON Quaternion object")
		return invalid_value

	var values:Array = json_object["value"] as Array
	if len(values) != 4:
		printerr("Invalid JSON Quaternion values !")
		return invalid_value

	return Quaternion(values[0], values[1], values[2], values[3])

func _parse_json_transform(json_object:Dictionary) -> UnityTransform:

	var invalid_value:UnityTransform = null

	if not json_object.has_all(["position", "rotation", "scale", "name", "parent_name"]):
		printerr("Invalid JSON Unity.Transform object")
		return invalid_value

	var position_data:Dictionary = json_object["position"] as Dictionary
	var rotation_data:Dictionary = json_object["rotation"] as Dictionary
	var scale_data:Dictionary = json_object["scale"] as Dictionary

	if position_data == null or rotation_data == null or scale_data == null:
		printerr(
			"Invalid position, rotation or scale data in this object : %s"
			% str(json_object))
		return invalid_value

	var unity_transform:UnityTransform = UnityTransform.new()
	unity_transform.position = _parse_json_object(position_data)
	unity_transform.rotation = _parse_json_object(rotation_data)
	unity_transform.scale = _parse_json_object(scale_data)

	return unity_transform



func _is_method_analysis(parsed_json:Dictionary) -> bool:
	var valid_json:bool = parsed_json.has_all(method_analysis_json_format.keys())
	if not valid_json:
		return false
	for key in method_analysis_json_format:
		var expected_type:int = method_analysis_json_format[key]
		var actual_field_type:int = typeof(parsed_json[key])
		if expected_type != actual_field_type:
			return false
	return parsed_json["@type"] == "@MethodAnalysis" and parsed_json["version"] == 1

func _method_analysis_get_input(
	inputs_outputs:Dictionary,
	input_name:String
) -> Dictionary:

	var invalid_value:Dictionary = {}

	if not inputs_outputs.has("input"):
		printerr("Invalid MethodInputOutput object !")
		return invalid_value

	var inputs = inputs_outputs["input"] as Array
	if inputs == null:
		printerr("This MethodInputOutput 'input' field is invalid")
		return invalid_value

	if inputs.is_empty():
		return invalid_value

	for input_value in inputs:
		var input_description:Dictionary = input_value as Dictionary
		if input_description == null:
			printerr(
				"Expected a Dictionary in 'input'. Got : %s"
				% [str(input_value)])
			continue
				
		if not input_description.has_all(["name", "content"]):
			printerr("Invalid input data : %s" % [str(input_description)])
			continue

		if input_description.name != input_name:
			continue

		return input_description["content"]

	return invalid_value

# Called when the node enters the scene tree for the first time.
func _ready():
	var stopped:bool = NodeHelpers.stop_if_any_is_null(
		self,
		[results_json_filepath],
		"TestShaderMotionSwingTwists")
	if stopped:
		return

	var parsed_json:Dictionary = JSON.parse_string(FileAccess.get_file_as_string(results_json_filepath))
	if parsed_json == null:
		printerr("Could not parse JSON data")
		return

	if not _is_method_analysis(parsed_json):
		printerr("%s is not a MethodAnalysis JSON file." % results_json_filepath)
		return

	var data = _parse_json_object(_method_analysis_get_input(
		parsed_json["execution"][0],
		"scaledSwingTwist"))
	printerr(data)

	print(ShaderMotionHelpers.swing_twist(data))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
