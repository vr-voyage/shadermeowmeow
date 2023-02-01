extends VBoxContainer

@export var skeleton_root_path: String
var analyzed_pixels: TileFrames = load("res://shader_motion/frames/result_frames.res")

var _cached_bones_names = ShaderMotionHelpers.MecanimBodyBone.keys()

var skeleton_bones: Array[Node3D]
var animation_names : Array[float]
var animation : Animation = Animation.new()

var animation_rotation_tracks:Dictionary = Dictionary()
var animation_position_tracks:Dictionary = Dictionary()

func _generate_dummy_bones_array() -> Array[Node3D]:
	var bones: Array[Node3D] = []

	bones.resize(ShaderMotionHelpers.MecanimBodyBone.LastBone)

	for bone in range(0, int(ShaderMotionHelpers.MecanimBodyBone.LastBone)):
		var bone_node: Node3D = Node3D.new()
		bone_node.name = _cached_bones_names[bone]
		bones[bone] = bone_node
	return bones

func _animation_path_for(
	bone:ShaderMotionHelpers.MecanimBodyBone,
	bone_names
) -> NodePath:
	return NodePath("%s:%s" % [str(skeleton_root_path), str(bone_names[bone])])

func _create_track_for(
	bone:ShaderMotionHelpers.MecanimBodyBone,
	base_animation:Animation,
	animation_type:Animation.TrackType,
	interpolation:Animation.InterpolationType
) -> int:
	var track_index:int = base_animation.add_track(animation_type)
	base_animation.track_set_path(track_index, _animation_path_for(bone, _cached_bones_names))
	base_animation.track_set_interpolation_type(track_index, animation_type)
	return track_index

func _prepare_animation_tracks(
	base_animation:Animation,
	bone_names
):
	for bone in range(0, int(ShaderMotionHelpers.MecanimBodyBone.LastBone)):
		animation_rotation_tracks[bone] = _create_track_for(
			bone,
			base_animation,
			Animation.TYPE_ROTATION_3D,
			Animation.INTERPOLATION_LINEAR)

	var hip_bone:ShaderMotionHelpers.MecanimBodyBone = ShaderMotionHelpers.MecanimBodyBone.Hips
	animation_position_tracks[hip_bone] = _create_track_for(
		hip_bone,
		base_animation,
		Animation.TYPE_POSITION_3D,
		Animation.INTERPOLATION_LINEAR)



# Called when the node enters the scene tree for the first time.
func _ready():

	var should_stop: bool = NodeHelpers.stop_if_any_is_null(
		self,
		[
			analyzed_pixels
		],
		"Tile Frames to Animation"
	)
	if should_stop:
		return

	skeleton_bones = _generate_dummy_bones_array()
	_prepare_animation_tracks(animation, _cached_bones_names)

	var current_animation_names : Array = analyzed_pixels.tiles.keys()
	current_animation_names.pop_back()
	for animation in current_animation_names:
		animation_names.push_back(animation)
	animation.length = current_animation_names.back()

	add_frames_to_animation(animation, analyzed_pixels)
	ResourceSaver.save(
		animation,
		"res://shader_motion/animations/exported_animation_faster_onready.tres")
	get_tree().quit()

func add_frames_to_animation(
	animation:Animation,
	frames_to_convert:TileFrames
):
	for frame_reference in frames_to_convert.tiles:
		_add_animation_frame(animation, frames_to_convert, frame_reference)

func _add_animation_frame(
	animation:Animation,
	frames:TileFrames,
	frame_reference:float,
):

	var motions: ShaderMotionHelpers.ParsedMotions = frames.get_motion_data_for(frame_reference)
	var animation_time:float = frame_reference

	var precomputed_skeleton_human_scale: float = 0.749392
	ShaderMotionHelpers._shadermotion_apply_human_pose(skeleton_bones, precomputed_skeleton_human_scale, motions)

	for bone in range(0, int(ShaderMotionHelpers.MecanimBodyBone.LastBone)):
		if not animation_rotation_tracks.has(bone):
			#printerr("Don't have a track for that, Jim.")
			continue

		# WARNING get_rotation_quaternion
		var unity_bone_rotation: Quaternion = skeleton_bones[bone].quaternion.normalized()
		if unity_bone_rotation == NodeHelpers.invalid_quaternion:
			#printerr("Invalid rotation for bone %d. Skipping" % [str(bone)])
			continue

		var godot_rotation: Quaternion = GodotHelpers.unity_rotation_to_godot(unity_bone_rotation)
		#(Basis.FLIP_X.inverse() * Basis(unity_bone_rotation) * Basis.FLIP_X).get_rotation_quaternion()

		var animation_track_index: int = animation_rotation_tracks[bone]
	
		animation.rotation_track_insert_key(
			animation_track_index, animation_time, godot_rotation)

	var hips_bone = ShaderMotionHelpers.MecanimBodyBone.Hips
	var hips_position_track_index:int = animation_position_tracks[hips_bone]
	var bone_position: Vector3 = skeleton_bones[hips_bone].position
	bone_position.z = -bone_position.z
	animation.position_track_insert_key(hips_position_track_index, animation_time, bone_position)



