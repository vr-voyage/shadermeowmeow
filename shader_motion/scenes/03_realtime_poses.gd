extends VideoStreamPlayer

@export var threed_model:Node3D

var _cached_bones_names
var skeleton_bones:Array[Node3D]
var godot_bones_rotations: Array[Quaternion] = []
var skeleton_bones_id:PackedInt32Array

# Called when the node enters the scene tree for the first time.
func _ready():
	godot_bones_rotations.resize(ShaderMotionHelpers.MecanimBodyBone.LastBone)
	_cached_bones_names = ShaderMotionHelpers.MecanimBodyBone.keys()
	skeleton_bones = _generate_dummy_bones_array()
	skeleton_bones_id = _shadermotion_to_skeleton_bones_relations(_cached_bones_names)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if paused:
		return

	if is_playing():
		var current_position:float = stream_position
		var tiles:Array = _retrieve_frames(current_position)
		_pose(skeleton_bones_id, tiles, current_position)


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

func _pose(
	bones_id:PackedInt32Array,
	frames:Array,
	stream_time:float,
):

	var motions: ShaderMotionHelpers.ParsedMotions = ShaderMotionHelpers.ParsedMotions.generate_from(frames, get_tiles_colors_from_slot)

	var precomputed_skeleton_human_scale: float = 0.749392
	ShaderMotionHelpers._shadermotion_apply_human_pose(skeleton_bones, precomputed_skeleton_human_scale, motions)

	godot_bones_rotations.resize(ShaderMotionHelpers.MecanimBodyBone.LastBone)
	godot_bones_rotations.fill(NodeHelpers.invalid_quaternion)

	for bone in range(0, int(ShaderMotionHelpers.MecanimBodyBone.LastBone)):
		# WARNING get_rotation_quaternion
		var unity_bone_rotation: Quaternion = skeleton_bones[bone].quaternion.normalized()
		if unity_bone_rotation == NodeHelpers.invalid_quaternion:
			#printerr("Invalid rotation for bone %d. Skipping" % [str(bone)])
			continue

		var godot_rotation: Quaternion = GodotHelpers.unity_rotation_to_godot(unity_bone_rotation)
		godot_bones_rotations[bone] = godot_rotation

	var hips_bone = ShaderMotionHelpers.MecanimBodyBone.Hips
	var bone_position: Vector3 = skeleton_bones[hips_bone].position
	bone_position.z = -bone_position.z

	threed_model.apply_shadermotion_movements(skeleton_bones_id, bone_position, godot_bones_rotations)

func _shadermotion_to_skeleton_bones_relations(bone_names:PackedStringArray) -> PackedInt32Array:
	return threed_model.get_bones_ids(bone_names)





