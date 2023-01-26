extends VBoxContainer

@export var shadermotion_bone_analyzer:PackedScene
@export var shadermotion_frame_pixels_display:TextureRect

@export var analyzed_bones_list:Container
@export var analyzed_frame:Texture2D
@export var analyzed_pixels:SpriteFrames

@export var bone_info_scene:PackedScene
@export var result_bones_list:Container

var motions:ShaderMotionHelpers.ParsedMotions = ShaderMotionHelpers.ParsedMotions.new()

func _generate_dummy_bones_array() -> Array[Node3D]:
	var bones:Array[Node3D] = []
	var bones_names = ShaderMotionHelpers.MecanimBodyBone.keys()
	bones.resize(ShaderMotionHelpers.MecanimBodyBone.LastBone)

	for bone in range(0, int(ShaderMotionHelpers.MecanimBodyBone.LastBone)):
		var bone_node:Node3D = Node3D.new()
		bone_node.name = bones_names[bone]
		bones[bone] = bone_node
	return bones

func analyse_pixels(shadermotion_pixels:SpriteFrames):
	NodeHelpers.remove_children_from(analyzed_bones_list)
	var mecanim_bone_names = ShaderMotionHelpers.MecanimBodyBone.keys()

	for bone in range(0, int(ShaderMotionHelpers.MecanimBodyBone.LastBone)):
		var analyzer = shadermotion_bone_analyzer.instantiate()
		analyzed_bones_list.add_child(analyzer)
		analyzer.analyze_bone_from(shadermotion_pixels, bone, mecanim_bone_names[bone])
		motions.swing_twists[bone].set_motion_data(
			analyzer.computed_swing_twist,
			analyzer.computed_rotation
		)

		if bone == ShaderMotionHelpers.MecanimBodyBone.Hips:
			motions.hips.set_transform(
				analyzer.computed_swing_twist,
				analyzer.computed_rotation,
				analyzer.computed_scale
			)

	print(motions)
	var skeleton_bones:Array[Node3D] = _generate_dummy_bones_array()
	ShaderMotionHelpers._shadermotion_apply_human_pose(
		skeleton_bones,
		0.749392,
		motions)
	for bone in skeleton_bones:
		var bone_info_panel = bone_info_scene.instantiate()
		result_bones_list.add_child(bone_info_panel)
		bone_info_panel.show_bone(bone)

# Called when the node enters the scene tree for the first time.
func _ready():
	var should_stop:bool = NodeHelpers.stop_if_any_is_null(
		self,
		[
			shadermotion_bone_analyzer,
			shadermotion_frame_pixels_display,
			analyzed_bones_list,
			analyzed_pixels,
			bone_info_scene,
			result_bones_list
		],
		"ShaderMotion to Mecanim Bones")
	if should_stop:
		return

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

