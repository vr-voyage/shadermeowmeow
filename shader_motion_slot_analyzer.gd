extends Control

@export var slot_value_label:Label

@export var square_raw:Control
@export var square_adjacent_raw:Control

@export var square_converted:Control
@export var square_adjacent_converted:Control

@export var gray_value:Label
@export var converted_value:Label

var texture_slots:Array[Texture2D]
var shader_motion_value:float = NAN
var shader_motion_swing_twist_value:float = NAN

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

func _vector3_add_to_int32_array(vec:Vector3, int32_array:PackedInt32Array):
	int32_array.append(vec.x)
	int32_array.append(vec.y)
	int32_array.append(vec.z)

func _int32_array_to_string(int32_array:PackedInt32Array, separator:String = "") -> String:
	var strings = PackedStringArray()
	
	for value in int32_array:
		strings.append(str(value))

	return separator.join(strings)

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

	var gray_code:PackedInt32Array = PackedInt32Array()
	_vector3_add_to_int32_array(square_converted.get_bgr_gray_code(), gray_code)
	_vector3_add_to_int32_array(square_adjacent_converted.get_bgr_gray_code(), gray_code)
	var decoded_value:int = gray_code_decoder(gray_code)
	shader_motion_value = shader_motion_gray_to_float(decoded_value)
	shader_motion_swing_twist_value = shader_motion_swing_twist(shader_motion_value)

	gray_value.text = _int32_array_to_string(gray_code)
	converted_value.text = "%d -> %f" % [decoded_value, shader_motion_value]

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

func _base3_total(numbers:PackedInt32Array) -> int:
	var exponent = len(numbers) - 1
	var accumulator = 0
	#printerr(_int32_array_to_string(numbers, ", "))
	for i in range(0, len(numbers)):
		var current_digit:int = numbers[i]
		var value:int = current_digit * pow(3, exponent)
		#printerr("%d : %d + %d (%d)" % [i, accumulator, value, current_digit])
		accumulator += value
		exponent -= 1
	return accumulator

const flip_codes:PackedInt32Array = [2,1,0]

func _flip_gray_code_array(numbers:PackedInt32Array):
	for i in range(0,len(numbers)):
		numbers[i] = flip_codes[numbers[i]]

func gray_code_decoder(numbers:PackedInt32Array) -> int:
	var result:PackedInt32Array = PackedInt32Array()
	for i in range(0,len(numbers)):
		result.append(numbers[i])
		if (_base3_total(result) & 1) == 1:
			_flip_gray_code_array(numbers)
	return _base3_total(numbers)

func shader_motion_gray_to_float(gray_value:int) -> float:
	return (gray_value / 364.0) - 1

func shader_motion_swing_twist(decoded_float_value:float) -> float:
	return decoded_float_value * 180
