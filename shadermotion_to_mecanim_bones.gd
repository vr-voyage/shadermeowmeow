extends VBoxContainer

@export var shadermotion_bone_analyzer:PackedScene
@export var shadermotion_frame_pixels_display:TextureRect

@export var analyzed_bones_list:Container
@export var analyzed_frame:Texture2D
@export var analyzed_pixels:SpriteFrames

class HipsData:
	var position:Vector3 = NodeHelpers.invalid_vector
	var rotation:Quaternion = NodeHelpers.invalid_quaternion
	var scale:float = NAN

	func set_transform(
		new_position:Vector3,
		new_rotation:Quaternion,
		new_scale:float
	):
		self.position = new_position
		self.rotation = new_rotation
		self.scale = new_scale

class MotionData:
	var swing_twist:Vector3 = NodeHelpers.invalid_vector
	var computed_rotation:Quaternion = NodeHelpers.invalid_quaternion
	var setup:bool = false

	func set_motion_data(swing_twist_data:Vector3, rotation_data:Quaternion):
		self.swing_twist = swing_twist_data
		self.computed_rotation = rotation_data
		self.setup = true

class ParsedMotions:
	var hips:HipsData = HipsData.new()
	var swing_twists:Array[MotionData]

	func _init():
		var swing_twists_values:Array[MotionData] = Array()
		swing_twists_values.resize(ShaderMotionHelpers.MecanimBodyBone.LastBone)

		for bone in range(int(ShaderMotionHelpers.MecanimBodyBone.LastBone)):
			swing_twists_values[bone] = MotionData.new()

		self.swing_twists = swing_twists_values

	func _add_vector3_field(strings:PackedStringArray, vector:Vector3):
		strings.append(str(vector.x))
		strings.append(str(vector.y))
		strings.append(str(vector.z))

	func _add_quaternion_field(strings:PackedStringArray, quaternion:Quaternion):
		strings.append(str(quaternion.x))
		strings.append(str(quaternion.y))
		strings.append(str(quaternion.z))
		strings.append(str(quaternion.w))

	func _generate_record_from(fields:PackedStringArray) -> String:
		return "\t".join(fields)

	func export_to_tsv(tsv_filepath:String):
		var records:PackedStringArray = PackedStringArray()
		var header:PackedStringArray = PackedStringArray(
			[
				"Bone name",
				"SwingTwist.x",
				"SwingTwist.y",
				"SwingTwist.z",
				"Rotation.x",
				"Rotation.y",
				"Rotation.z",
				"Rotation.w",
				"Scale"
			]
		)
		var bone_names = ShaderMotionHelpers.MecanimBodyBone.keys()


		records.append(_generate_record_from(header))

		var current_record:PackedStringArray = PackedStringArray()
		for bone in range(int(ShaderMotionHelpers.MecanimBodyBone.LastBone)):

			current_record.clear()
			current_record.append(bone_names[bone])

			if bone != ShaderMotionHelpers.MecanimBodyBone.Hips:
				var bone_record:MotionData = swing_twists[bone]
				_add_vector3_field(current_record, bone_record.swing_twist)
				_add_quaternion_field(current_record, bone_record.computed_rotation)
				current_record.append(str(NAN))
			else:
				_add_vector3_field(current_record, hips.position)
				_add_quaternion_field(current_record, hips.rotation)
				current_record.append(str(hips.scale))
			records.append(_generate_record_from(current_record))

		var tsv_content:String = "\n".join(records)
		var tsv_file = FileAccess.open(tsv_filepath, FileAccess.WRITE)
		tsv_file.store_string(tsv_content)
		

var motions:ParsedMotions = ParsedMotions.new()

func analyse_pixels(shadermotion_pixels:SpriteFrames):
	NodeHelpers.remove_children_from(analyzed_bones_list)
	var mecanim_bone_names = ShaderMotionHelpers.MecanimBodyBone.keys()

	for bone in range(0, int(ShaderMotionHelpers.MecanimBodyBone.LastBone)):
		var analyzer = shadermotion_bone_analyzer.instantiate()
		analyzed_bones_list.add_child(analyzer)
		analyzer.analyze_bone_from(shadermotion_pixels, bone, mecanim_bone_names[bone])
		if bone != ShaderMotionHelpers.MecanimBodyBone.Hips:
			motions.swing_twists[bone].set_motion_data(
				analyzer.computed_swing_twist,
				analyzer.computed_rotation
			)
		else:
			motions.hips.set_transform(
				analyzer.computed_swing_twist,
				analyzer.computed_rotation,
				analyzer.computed_scale
			)

	print(motions)

# Called when the node enters the scene tree for the first time.
func _ready():
	NodeHelpers.stop_if_any_is_null(
		self,
		[
			shadermotion_bone_analyzer,
			analyzed_bones_list,
			analyzed_pixels
		],
		"ShaderMotion to Mecanim Bones")
	analyse_pixels(analyzed_pixels)
	shadermotion_frame_pixels_display.texture = ShaderMotionHelpers.get_shader_motion_tiles_part(analyzed_frame)
	pass # Replace with function body.



func _on_export_button_pressed():
	var filepath:String = (
		"user://export_%d.tsv"
		% [int(Time.get_unix_time_from_system())]
	)
	motions.export_to_tsv(filepath)
	OS.shell_open(ProjectSettings.globalize_path(filepath))

