extends VideoStreamPlayer

var frames : SpriteFrames = null

func _enter_tree():
	frames = SpriteFrames.new()
	play()


func _process(_delta):
	var texture : Texture2D = get_video_texture()
	ShaderMotionHelpers.get_shader_motion_tiles_from_texture(texture.duplicate(), frames, stream_position)
	if stream_position > 0.5:
		ResourceSaver.save(frames, "res://shader_motion/frames/result_frames.res", ResourceSaver.FLAG_BUNDLE_RESOURCES)
		get_tree().quit()
