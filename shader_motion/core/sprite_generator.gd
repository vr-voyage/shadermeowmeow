extends VideoStreamPlayer

var frames : Dictionary

func _enter_tree():
	playing = false
	play()

		
func _process(_delta):
	var new_tiles : Dictionary = ShaderMotionHelpers.get_shader_motion_tiles_from_texture(get_video_texture().get_image(), stream_position)
	frames.merge(new_tiles)
	var tiles : TileFrames = TileFrames.new()
	tiles.tiles = frames
	print(stream_position)
	ResourceSaver.save(tiles, "res://shader_motion/frames/result_frames.res")
	if stream_position < 2:
		get_tree().quit()
