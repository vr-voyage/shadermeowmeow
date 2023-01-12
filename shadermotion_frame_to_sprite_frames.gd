extends Control

@export var shadermotion_video_frame:Texture2D

@export var total_tiles:int
@export var tiles_per_column:int
@export var tile_width:int
@export var tile_height:int

@export var container:Container

func shadermotion_tile_rect(tile_index:int, adjacent:int) -> Rect2:
	var block_column:int = tile_index / tiles_per_column
	var block_row:int = tile_index % tiles_per_column
	var block_x:int = block_column * (tile_width * 2)
	var block_y:int = block_row
	var x:int = block_x if adjacent == 0 else block_x + tile_width
	var y:int = block_y * tile_height
	
	var ret:Rect2 = Rect2(x, y, tile_width, tile_height)
	printerr("Tile : %d - Rect : (%s)" % [tile_index, str(ret)])
	return ret

func get_shadermotion_tile(main_texture:Texture2D, tile_index:int, adjacent:bool) -> Texture2D:
	var ret_texture = AtlasTexture.new()
	ret_texture.atlas = main_texture
	ret_texture.region = shadermotion_tile_rect(tile_index, int(adjacent))
	return ret_texture

func _debug_show_extracted_tiles(tile:Texture2D, tile_adjacent:Texture2D):
	var hbox_container:HBoxContainer = HBoxContainer.new()
	var tile_texrect:TextureRect = TextureRect.new()
	var tile_adjacent_texrect:TextureRect = TextureRect.new()
	tile_texrect.texture = tile
	tile_texrect.size = Vector2(tile_width,tile_height)
	tile_adjacent_texrect.texture = tile_adjacent
	tile_adjacent_texrect.size = Vector2(tile_width,tile_height)
	container.add_child(hbox_container)
	hbox_container.add_child(tile_texrect)
	hbox_container.add_child(tile_adjacent_texrect)

# Called when the node enters the scene tree for the first time.
func _ready():
	print("%d x %d" % [shadermotion_video_frame.get_width(), shadermotion_video_frame.get_height()])

	var frames = SpriteFrames.new()
	frames.add_animation("default")
	var i:int = 0
	for frame_block_name in ShaderMotionHelpers.block_tiles:
		var frame_block:Array = ShaderMotionHelpers.block_tiles[frame_block_name]
		for tile_index in frame_block:
			var tile:Texture2D = get_shadermotion_tile(shadermotion_video_frame, tile_index, false)
			var tile_adjacent:Texture2D = get_shadermotion_tile(shadermotion_video_frame, tile_index, true)
			frames.add_frame("default", tile, i)
			frames.add_frame("default", tile_adjacent, i+1)
			i += 2
			# _debug_show_extracted_tiles(tile, tile_adjacent)
	ResourceSaver.save(
		frames,
		"res://tests/result_frames.tres",
		ResourceSaver.FLAG_BUNDLE_RESOURCES)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
