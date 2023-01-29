extends VideoStreamPlayer


func _process(delta):
	var texture : Texture = get_video_texture()
	print("Tick and Dimensions in texture: %s %s" % [Time.get_ticks_msec(), texture.get_size()]) 
