extends Control

@export var shadermotion_video_frame: Texture2D

@export var total_tiles: int
@export var tiles_per_column: int
@export var tile_width: int
@export var tile_height: int

@export var container: Container


func _debug_show_extracted_tiles(tile: Texture2D, tile_adjacent: Texture2D):
	var hbox_container: HBoxContainer = HBoxContainer.new()
	var tile_texrect: TextureRect = TextureRect.new()
	var tile_adjacent_texrect: TextureRect = TextureRect.new()
	tile_texrect.texture = tile
	tile_texrect.size = Vector2(tile_width, tile_height)
	tile_adjacent_texrect.texture = tile_adjacent
	tile_adjacent_texrect.size = Vector2(tile_width, tile_height)
	container.add_child(hbox_container)
	hbox_container.add_child(tile_texrect)
	hbox_container.add_child(tile_adjacent_texrect)


# Called when the node enters the scene tree for the first time.
func _ready():
	print("%d x %d" % [shadermotion_video_frame.get_width(), shadermotion_video_frame.get_height()])

	var frames = ShaderMotionHelpers.get_shader_motion_tiles_from_texture(shadermotion_video_frame)
	#_debug_show_extracted_tiles(tile, tile_adjacent)
	ResourceSaver.save(frames, "res://shader_motion/frames/result_frames_2.tres", ResourceSaver.FLAG_BUNDLE_RESOURCES)
