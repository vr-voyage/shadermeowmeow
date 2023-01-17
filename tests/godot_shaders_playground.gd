extends Node2D

const color_tile_radix:int = 3
const color_tile_len:int   = 2
const video_resolution:Vector2i = Vector2i(80, 45)
const tile_count:Vector2i = video_resolution / Vector2i(color_tile_len, 1)

@export var _main_tex:Texture2D
const _main_tex_st:Vector4 = Vector4(1.0, 1.0, 0.0, 0.0)
const _apply_gamma:float = 0.0
var linear_clamp:RDSamplerState = RDSamplerState.new()

func _set_linear_clamp():
	linear_clamp.repeat_u = RenderingDevice.SAMPLER_REPEAT_MODE_CLAMP_TO_BORDER
	linear_clamp.repeat_v = RenderingDevice.SAMPLER_REPEAT_MODE_CLAMP_TO_BORDER
	linear_clamp.repeat_w = RenderingDevice.SAMPLER_REPEAT_MODE_CLAMP_TO_BORDER
	linear_clamp.min_filter = RenderingDevice.SAMPLER_FILTER_LINEAR
	linear_clamp.max_filter = RenderingDevice.SAMPLER_FILTER_LINEAR
	linear_clamp.mip_filter = RenderingDevice.SAMPLER_FILTER_NEAREST

func gray_decoder_add(
	state:Vector3,
	value:float,
	radix:int,
	continuation:bool = true
):
	var state_is_odd:bool = bool(int(state.x) & 1)
	value = radix - 1 - value if state_is_odd else value
	# ???
	var rounded_value:float = round(value)
	state.x = state.x * radix + rounded_value
	
	

func decode_video_snorm(tiles:ColorTile):
	var state:Vector3 = Vector3(0,0,0)
	for color in range(0, color_tile_len):
		var current_color:Color = tiles.data[color]
		current_color *= (color_tile_radix - 1)
		

func _fake_texture_sampler(
	texture:Texture2D,
	sampler:RDSamplerState,
	uv:Vector2,
	lod:int
) -> Color:
	# Won't work : Compressed images !
	#var image:Image = texture.get_image()
	#var image_dimensions:Vector2 = texture.get_size()
	#return image.get_pixelv(Vector2i(image_dimensions * uv))
	var default_color:Color = Color(0,0,0,0)
	if uv.is_equal_approx(Vector2(0.00625, 0.744444)):
		return Color(1,1,1,1)
	elif uv.is_equal_approx(Vector2(0.01875, 0.744444)):
		return Color(1.0, 0.12844, 0.30196, 0.00)
	else:
		return default_color

func linear_to_gamma(linear_color:Color) -> Color:
	return linear_color

class ColorTile:
	var data:PackedColorArray = PackedColorArray()
	func _init():
		data.resize(2)

func _hlsl_lerp_vec2(a:Vector2, b:Vector2, weight:Vector2):
	return Vector2(
		lerpf(a.x, b.x, weight.x),
		lerpf(a.y, b.y, weight.y)
	)

func log_func(method_name:String, variables:Dictionary):
	print("[%s]\n" % [method_name])
	for var_name in variables:
		var current_variable = variables[var_name]
		print("\t%s : %s" % [var_name, str(current_variable)])

func _sm_sample_tile(
	color_tile:ColorTile,
	texture:Texture2D,
	rect:Vector4,
	sample_gamma:bool
):
	for i in range(0, color_tile_len):
		var block_pixel_middle:float = (float(i) + 0.5)/color_tile_len
		var lerp_value:Vector2 = Vector2(block_pixel_middle, 0.5)
		var rect_xy:Vector2 = Vector2(rect.x, rect.y)
		var rect_zw:Vector2 = Vector2(rect.z, rect.w)
		var lerp_result:Vector2 = _hlsl_lerp_vec2(rect_xy, rect_zw, lerp_value)
		var linear_color:Color = _fake_texture_sampler(texture, linear_clamp, lerp_result, 0)
		if not sample_gamma:
			color_tile.data[i] = linear_to_gamma(linear_color)
		log_func(
			"_sm_sample_tile",
			{
				"rect": rect,
				"i": i,
				"block_pixel_middle": block_pixel_middle,
				"lerp_value": lerp_value,
				"lerp_result": lerp_result,
				"color_tile": color_tile.data[i]
			})
	pass

func _sm_get_tile_rect(uv:Vector2):
	var tiles = floor(uv * Vector2(tile_count))
	var vec4_tile:Vector4 = Vector4(tiles.x, tiles.y, tiles.x, tiles.y)
	print("[_sm_get_tile_rect] vec4_tile : %s" % str(vec4_tile))
	return(
		(vec4_tile + Vector4(0, 0, 1, 1))
		/ Vector4(tile_count.x, tile_count.y, tile_count.x, tile_count.y)
	)

func _sm_sample_snorm(uv:Vector2):
	var rect:Vector4 = _sm_get_tile_rect(uv)
	print("[_sm_sample_snorm] _sm_get_tile_rect(%s) : %s" % [str(uv), str(rect)])
	if uv.x > 0.5:
		var x = rect.x
		var z = rect.z
		rect.x = z
		rect.z = x
		print("[_sm_sample_snorm] swizzle : %s" % [str(rect)])
	var c:ColorTile = ColorTile.new()
	var tex_tiling:Vector4 = Vector4(
		_main_tex_st.x, _main_tex_st.y,
		_main_tex_st.x, _main_tex_st.y)
	var tex_offset:Vector4 = Vector4(
		_main_tex_st.z, _main_tex_st.w,
		_main_tex_st.z, _main_tex_st.w
	)
	var scaled_rect:Vector4 = rect * tex_tiling
	var transformed_rect:Vector4 = scaled_rect + tex_offset
	print(
		"[_sm_sample_snorm]\n\tscaled_rect : %s\n\ttransformed_rect : %s"
		% [str(scaled_rect), str(transformed_rect)])
	_sm_sample_tile(c, _main_tex, transformed_rect, _apply_gamma)
	
	

var provided_uv:Vector2 = Vector2(0.00937, 0.73889)

func _frag():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	print(tile_count)
	_sm_sample_snorm(provided_uv)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
