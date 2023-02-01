extends Resource
class_name TileFrames
@export var tiles : Dictionary


func _init(p_tiles = {}):
	tiles = p_tiles

func get_tiles_at(frame_time:float) -> Array:
	if not tiles.has(frame_time):
		printerr("[TileFrames] No animation for time %f" % frame_time)
		return []
	return tiles[frame_time]

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

func get_motion_data_for(frame_time:float) -> ShaderMotionHelpers.ParsedMotions:
	var frame_tiles:Array = get_tiles_at(frame_time)

	if frame_tiles.is_empty():
		printerr(
			"[TileFrames.get_motion_data_for] Failed to get the frames at time %f"
			% frame_tiles)
		return null

	return ShaderMotionHelpers.ParsedMotions.generate_from(
		frame_tiles,
		get_tiles_colors_from_slot)

#	if not ShaderMotionHelpers.is_valid_mecanim_bone(bone):
#		printerr("Invalid bone provided : %d" % [str(bone)])
#		return result
#
#	var bone_tiles:Array = ShaderMotionHelpers.mecanim_bone_tiles[bone]
