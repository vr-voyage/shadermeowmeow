extends VideoStreamPlayer

var frames : SpriteFrames = SpriteFrames.new()

func _enter_tree():
	play()

func _process(_delta):
	var texture : Texture2D = get_video_texture()
	ShaderMotionHelpers.get_shader_motion_tiles_from_texture(texture, frames, stream_position)
	if stream_position > 1:
		ResourceSaver.save(frames, "res://shader_motion/frames/result_frames.res", ResourceSaver.FLAG_BUNDLE_RESOURCES)
		get_tree().quit()
