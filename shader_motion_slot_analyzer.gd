extends Control

@export var slot_value_label:Label

@export var square_raw:Control
@export var square_adjacent_raw:Control

@export var square_converted:Control
@export var square_adjacent_converted:Control

@export var gray_value:Label
@export var converted_value:Label

var texture_slots:Array[Texture2D]

# Called when the node enters the scene tree for the first time.
func _ready():
	var required_values : Array = [
		slot_value_label,
		square_raw,
		square_adjacent_raw,
		square_converted,
		square_adjacent_converted,
		gray_value,
		converted_value
	]
	for value in required_values:
		if value == null:
			printerr("[%s] [ShaderMotion Slot Analyzer] Component badly setup" % name)
			printerr("[%s] [ShaderMotion Slot Analyzer] Disabling" % name)
			process_mode = Node.PROCESS_MODE_DISABLED
			return

const bad_color : Color = Color(0,0,0,0)

func _sample_pixel_color_at_middle(texture:Texture2D) -> Color:
	var image = texture.get_image()
	if image == null:
		printerr("[%s] [ShaderMotion Slot Analyzer] No image on your texture !" % name)
		return bad_color
	return image.get_pixelv(image.get_size()/2)

func _join_vector3_as_string(vec:Vector3, separator:String = "") -> String:
	return separator.join([vec[0], vec[1], vec[2]])

func _show_slot_samples(square_texture:Texture2D, square_adjacent_texture:Texture2D):
	var square_sample = _sample_pixel_color_at_middle(square_texture)
	var square_adjacent_sample = _sample_pixel_color_at_middle(square_adjacent_texture)
	
	if square_sample == bad_color or square_adjacent_sample == bad_color:
		printerr("[%s] [ShaderMotion Slot Analyzer] Could not sample the texture :C" % name)
		return

	square_raw.show_color(square_sample)
	square_converted.show_shadermotion_color(square_sample)
	square_adjacent_raw.show_color(square_adjacent_sample)
	square_adjacent_converted.show_shadermotion_color(square_adjacent_sample)

	gray_value.text = "%s%s" % [
		_join_vector3_as_string(square_converted.get_bgr_gray_code()),
		_join_vector3_as_string(square_adjacent_converted.get_bgr_gray_code())
	]
	

func show_slot(pixels:SpriteFrames, slot_idx:int):
	var frame_idx = slot_idx*2
	var square_texture = pixels.get_frame("default", frame_idx)
	var square_adjacent_texture = pixels.get_frame("default", frame_idx+1)
	if square_texture == null or square_adjacent_texture == null:
		printerr(
			"[%s] [ShaderMotion Slot Analyzer] Check your frames [%d,%d], mate !"
			% [name, frame_idx, frame_idx+1])
		return

	slot_value_label.text = str(slot_idx)
	_show_slot_samples(square_texture, square_adjacent_texture)
