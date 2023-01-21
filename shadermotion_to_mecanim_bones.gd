extends VBoxContainer

@export var shadermotion_bone_analyzer:PackedScene
@export var shadermotion_frame_pixels_display:TextureRect

@export var analyzed_bones_list:Container
@export var analyzed_frame:Texture2D
@export var analyzed_pixels:SpriteFrames

func analyse_pixels(shadermotion_pixels:SpriteFrames):
	NodeHelpers.remove_children_from(analyzed_bones_list)
	var mecanim_bone_names = ShaderMotionHelpers.MecanimBodyBone.keys()

	for bone in range(0, int(ShaderMotionHelpers.MecanimBodyBone.LastBone)):
		var analyzer = shadermotion_bone_analyzer.instantiate()
		analyzed_bones_list.add_child(analyzer)
		analyzer.analyze_bone_from(shadermotion_pixels, bone, mecanim_bone_names[bone])

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

func _export_content_to(tsv_filepath:String):
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
			"Rotation.w"
		]
	)
	records.append(_generate_record_from(header))

	var current_record:PackedStringArray = PackedStringArray()
	for analyzer in analyzed_bones_list.get_children():
		if not analyzer.computed:
			continue
		current_record.clear()
		current_record.append(analyzer.analyzed_bone_name)
		_add_vector3_field(current_record, analyzer.computed_swing_twist)
		_add_quaternion_field(current_record, analyzer.computed_rotation)
		records.append(_generate_record_from(current_record))

	var tsv_content:String = "\n".join(records)
	var tsv_file = FileAccess.open(tsv_filepath, FileAccess.WRITE)
	tsv_file.store_string(tsv_content)

func _on_export_button_pressed():
	var filepath:String = (
		"user://export_%d.tsv"
		% [int(Time.get_unix_time_from_system())]
	)
	_export_content_to(filepath)
	OS.shell_open(ProjectSettings.globalize_path(filepath))

