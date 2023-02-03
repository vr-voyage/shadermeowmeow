extends VideoStreamPlayer

@export var skeleton_root_path:String
@export var generated_animation_filepath:String
@export var max_seconds_saved:float

var animation:Animation = Animation.new()
var _cached_bones_names

var animation_rotation_tracks:Dictionary = Dictionary()
var animation_position_tracks:Dictionary = Dictionary()

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


var skeleton_bones:Array[Node3D]
func _generate_dummy_bones_array() -> Array[Node3D]:
	var bones: Array[Node3D] = []

	bones.resize(ShaderMotionHelpers.MecanimBodyBone.LastBone)

	for bone in range(0, int(ShaderMotionHelpers.MecanimBodyBone.LastBone)):
		var bone_node: Node3D = Node3D.new()
		bone_node.name = _cached_bones_names[bone]
		bones[bone] = bone_node
	return bones

func _slot_to_frame_index(
	slot_index:int
) -> int:
	return slot_index * 2

func _slot_to_adjacent_frame_index(
	slot_index:int
) -> int:
	return _slot_to_frame_index(slot_index) + 1

func get_tiles_colors_from_slot(
	frame_tiles:Array,
	slot_index:int
) -> Array[Color]:

	var result:Array[Color] = []

	var tile_index:int = _slot_to_frame_index(slot_index)
	var adjacent_tile_index:int = _slot_to_adjacent_frame_index(slot_index)
	var n_tiles:int = len(frame_tiles)

	if tile_index >= n_tiles or adjacent_tile_index >= n_tiles:
		printerr(
			"(slot %d) Tiles %d and %d are out of bounds (tiles parsed : %d)"
			% [str(slot_index), str(tile_index), str(adjacent_tile_index), str(n_tiles)])
		return result

	var tile_image:Image = frame_tiles[tile_index]
	var adjacent_tile_image:Image = frame_tiles[adjacent_tile_index]

	if tile_image == null or adjacent_tile_image == null:
		printerr(
			"(slot %d) Failed to get the tiles %d and %d images"
			% [str(slot_index), str(tile_index), str(adjacent_tile_index)])
		return result

	var tile_color:Color = GodotHelpers.image_sample_center_pixel(tile_image)
	var adjacent_tile_color:Color = GodotHelpers.image_sample_center_pixel(adjacent_tile_image)

	if tile_color == GodotHelpers.invalid_color or adjacent_tile_color == GodotHelpers.invalid_color:
		printerr(
			"(slot %d) Could not sample the colors of tiles %d and %d images"
			% [str(slot_index), str(tile_index), str(adjacent_tile_index)])
		return result

	result.append(tile_color)
	result.append(adjacent_tile_color)

	return result

func _retrieve_frames(stream_time:float) -> Array:
	return ShaderMotionHelpers.get_shader_motion_tiles_from_texture(get_video_texture().get_image(), stream_time)[stream_time]

func _add_animation_frame(
	animation:Animation,
	frames:Array,
	stream_time:float,
):

	var motions: ShaderMotionHelpers.ParsedMotions = ShaderMotionHelpers.ParsedMotions.generate_from(frames, get_tiles_colors_from_slot)

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
			animation_track_index, stream_time, godot_rotation)

	var hips_bone = ShaderMotionHelpers.MecanimBodyBone.Hips
	var hips_position_track_index:int = animation_position_tracks[hips_bone]
	var bone_position: Vector3 = skeleton_bones[hips_bone].position
	bone_position.z = -bone_position.z
	animation.position_track_insert_key(hips_position_track_index, stream_time, bone_position)

func save_and_quit(stream_time:float):
	animation.length = stream_time
	ResourceSaver.save(animation, generated_animation_filepath)
	get_tree().quit()


# Called when the node enters the scene tree for the first time.
func _ready():
	_cached_bones_names = ShaderMotionHelpers.MecanimBodyBone.keys()
	skeleton_bones = _generate_dummy_bones_array()
	_prepare_animation_tracks(animation, _cached_bones_names)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if paused:
		return

	if playing:
		var current_position:float = stream_position
		var tiles:Array = _retrieve_frames(current_position)
		_add_animation_frame(animation, tiles, current_position)
	else:
		save_and_quit(stream_position)

	if stream_position >= max_seconds_saved:
		save_and_quit(stream_position)
