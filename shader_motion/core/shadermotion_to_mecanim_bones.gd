extends VBoxContainer

@export var shadermotion_bone_analyzer: PackedScene
@export var shadermotion_frame_pixels_display: TextureRect

@export var analyzed_bones_list: Container
@export var analyzed_pixels: TileFrames = load("res://shader_motion/frames/result_frames.res")

@export var bone_info_scene: PackedScene
@export var result_bones_list: Container

@export var skeleton_root_path: String
@export var animated_node_path: NodePath


func _generate_dummy_bones_array() -> Array[Node3D]:
	var bones: Array[Node3D] = []
	var bones_names = ShaderMotionHelpers.MecanimBodyBone.keys()
	bones.resize(ShaderMotionHelpers.MecanimBodyBone.LastBone)

	for bone in range(0, int(ShaderMotionHelpers.MecanimBodyBone.LastBone)):
		var bone_node: Node3D = Node3D.new()
		bone_node.name = bones_names[bone]
		bones[bone] = bone_node
	return bones

var skeleton_bones: Array[Node3D] = _generate_dummy_bones_array()

var animation_names : Array[float]

var animation : Animation = Animation.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	var should_stop: bool = NodeHelpers.stop_if_any_is_null(
		self,
		[
			shadermotion_bone_analyzer,
			shadermotion_frame_pixels_display,
			analyzed_bones_list,
			analyzed_pixels,
			bone_info_scene,
			result_bones_list
		],
		"ShaderMotion to Mecanim Bones"
	)
	if should_stop:
		return

	NodeHelpers.remove_children_from(analyzed_bones_list)
	var current_animation_names : Array = analyzed_pixels.tiles.keys()
	current_animation_names.pop_back()
	for animation in current_animation_names:
		animation_names.push_back(animation)
	animation.length = current_animation_names.back()
	print(animation.length)
	
	var bone_names = ShaderMotionHelpers.MecanimBodyBone.keys()

	for bone in range(0, int(ShaderMotionHelpers.MecanimBodyBone.LastBone)):
		var unity_bone_rotation: Quaternion = skeleton_bones[bone].quaternion.normalized()
		if unity_bone_rotation == NodeHelpers.invalid_quaternion:
			continue
		var godot_rotation: Quaternion = (Basis.FLIP_X.inverse() * Basis(unity_bone_rotation) * Basis.FLIP_X).get_rotation_quaternion()
		var bone_name: String = bone_names[bone]
		var animation_path: NodePath = NodePath("%s:%s" % [skeleton_root_path, bone_name])

		var current_index: int = animation.get_track_count()
		animation.add_track(Animation.TYPE_ROTATION_3D)
		animation.track_set_path(current_index, animation_path)
		animation.track_set_interpolation_type(current_index, Animation.INTERPOLATION_CUBIC)
	
	print(animation_names)
	
func _process(delta):
	calc_frame()
		
func calc_frame() -> void:
	if not animation_names.size():
		ResourceSaver.save(animation, "res://shader_motion/animations/exported_animation.res")
		get_tree().quit()
		return
	var animation_time = animation_names[0]
	animation_names.pop_front()
	var motions: ShaderMotionHelpers.ParsedMotions = ShaderMotionHelpers.ParsedMotions.new()
	var mecanim_bone_names = ShaderMotionHelpers.MecanimBodyBone.keys()
	var bone_names = ShaderMotionHelpers.MecanimBodyBone.keys()
	for bone in range(0, int(ShaderMotionHelpers.MecanimBodyBone.LastBone)):
		var analyzer = shadermotion_bone_analyzer.instantiate()
		analyzed_bones_list.add_child(analyzer)
		analyzer.analyze_bone_from(analyzed_pixels, animation_time, bone, mecanim_bone_names[bone])
		motions.swing_twists[bone].set_motion_data(analyzer.computed_swing_twist, analyzer.computed_rotation)

		if bone == ShaderMotionHelpers.MecanimBodyBone.Hips:
			motions.hips.set_transform(
				analyzer.computed_swing_twist, analyzer.computed_rotation, analyzer.computed_scale
			)
	print(animation_time)
	var skeleton_bones: Array[Node3D] = _generate_dummy_bones_array()
	var precomputed_skeleton_human_scale: float = 0.749392
	ShaderMotionHelpers._shadermotion_apply_human_pose(skeleton_bones, precomputed_skeleton_human_scale, motions)
	for bone in skeleton_bones:
		var bone_info_panel = bone_info_scene.instantiate()
		result_bones_list.add_child(bone_info_panel)
		bone_info_panel.show_bone(bone)

	for bone in range(0, int(ShaderMotionHelpers.MecanimBodyBone.LastBone)):
		var unity_bone_rotation: Quaternion = skeleton_bones[bone].quaternion.normalized()
		if unity_bone_rotation == NodeHelpers.invalid_quaternion:
			continue
		var godot_rotation: Quaternion = (Basis.FLIP_X.inverse() * Basis(unity_bone_rotation) * Basis.FLIP_X).get_rotation_quaternion()
		var bone_name: String = bone_names[bone]
		var animation_path: NodePath = NodePath("%s:%s" % [skeleton_root_path, bone_name])

		var current_index: int = animation.find_track(animation_path, Animation.TYPE_ROTATION_3D)
		if current_index == -1:
			continue
		animation.rotation_track_insert_key(current_index, animation_time, godot_rotation)
