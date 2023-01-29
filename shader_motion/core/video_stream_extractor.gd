extends VideoStreamPlayer

func _ready():
	Engine.time_scale = 1.0 / 10

func _process(delta):
	print("Tick and Dimensions in texture: %s %s" % [stream_position, get_video_texture().get_size()])
	ResourceSaver.save(get_video_texture(), "res://shader_motion/shadermotion_the_devouring_frames/frame_%f.png" % stream_position)
