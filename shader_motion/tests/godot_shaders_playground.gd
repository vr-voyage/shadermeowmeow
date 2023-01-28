extends Node2D

const color_tile_radix:int = 3
const color_tile_len:int   = 2
const video_resolution:Vector2i = Vector2i(80, 45)
const tile_count:Vector2i = video_resolution / Vector2i(color_tile_len, 1)
const tile_pow:float = pow(color_tile_radix, color_tile_len * 3)

@export var _main_tex:Texture2D
const _main_tex_st:Vector4 = Vector4(1.0, 1.0, 0.0, 0.0)
const _apply_gamma:float = 0.0
var linear_clamp:RDSamplerState = RDSamplerState.new()

func _set_linear_clamp() -> void:
	linear_clamp.repeat_u = RenderingDevice.SAMPLER_REPEAT_MODE_CLAMP_TO_BORDER
	linear_clamp.repeat_v = RenderingDevice.SAMPLER_REPEAT_MODE_CLAMP_TO_BORDER
	linear_clamp.repeat_w = RenderingDevice.SAMPLER_REPEAT_MODE_CLAMP_TO_BORDER
	linear_clamp.min_filter = RenderingDevice.SAMPLER_FILTER_LINEAR
	linear_clamp.max_filter = RenderingDevice.SAMPLER_FILTER_LINEAR
	linear_clamp.mip_filter = RenderingDevice.SAMPLER_FILTER_NEAREST

func hlsl_vector2_ternary(
	condition:Vector2,
	if_values:Vector2,
	else_values:Vector2
) -> Vector2:
	return Vector2(
		if_values.x if bool(condition.x) else else_values.x,
		if_values.y if bool(condition.y) else else_values.y
	)

func hlsl_vector3_ternary(
	condition:Vector3,
	if_values:Vector3,
	else_values:Vector3
) -> Vector3:
	return Vector3(
		if_values.x if bool(condition.x) else else_values.x,
		if_values.y if bool(condition.y) else else_values.y,
		if_values.z if bool(condition.z) else else_values.z
	)

func hlsl_vector2_and(
	condition_a:Vector2i,
	condition_b:Vector2i
) -> Vector2i:
	return Vector2i(
		(condition_a.x & condition_b.x),
		(condition_a.y & condition_b.y)
	)

func hlsl_vector2_equal(
	vector_a:Vector2,
	vector_b:Vector2
) -> Vector2i:
	return Vector2i(
		vector_a.x == vector_b.x,
		vector_a.y == vector_b.y
	)

func hlsl_max_vec2(vector_a:Vector2, vector_b:Vector2) ->  Vector2:
	return Vector2(
		maxf(vector_a.x, vector_b.x),
		maxf(vector_a.y, vector_b.y)
	)

func _hlsl_lerp_vec2(a:Vector2, b:Vector2, weight:Vector2):
	return Vector2(
		lerpf(a.x, b.x, weight.x),
		lerpf(a.y, b.y, weight.y)
	)

func _sm_gray_decoder_sum(
	state:Vector3
) -> float:
	# Yet another reproduction of ShaderMotion algorithm.
	# This one reproduces gray_decoder_sum.
	# Again, this is mostly a copy-paste adapation since I have
	# zero idea about what the algorithm is doing.
	#
	# Original HLSL algorithm :
	# float gray_encoder_sum(float3 state) {
	# 	float2 p = max(0, state.zy * float2(+2, -2));
	# 	return (min(p.x,p.y)/max(max(p.x,p.y)-p.x*p.y,1e-5)*(p.x-p.y)+(p.x-p.y)) * 0.5 + state.x;
	# }

	var state_zy:Vector2 = Vector2(state.z, state.y)
	var positive_zy:Vector2 = hlsl_max_vec2(
		Vector2(0, 0),
		state_zy * Vector2(+2, -2)
	)

	var max_zy:float = max(positive_zy[0], positive_zy[1])
	var min_zy:float = min(positive_zy[0], positive_zy[1])
	var diff_zy:float = positive_zy[0] - positive_zy[1]
	var prod_zy:float = positive_zy[0] * positive_zy[1]

	var not_zero_positive:float = maxf(max_zy - prod_zy, 1e-5)
	var unknown_operation:float = (
		min_zy / not_zero_positive * diff_zy + diff_zy
	)
	var result = unknown_operation * 0.5 + state.x

	log_func(
		"_sm_gray_decoder_sum",
		{
			"state": state,
			"state_zy": state_zy,
			"positive_zy": positive_zy,
			"result": result
		}
	)

	return result

func _sm_gray_decoder_add(
	state:Vector3,
	value:float,
	radix:int,
	continuation:bool = true
):
	# This is a reproduction of ShaderMotion gray_decoder_add
	# algorithm, that decodes Gray Code values encoded in
	# ternary (0, 1, 2).

	# I have no idea about what the algoritm is doing, so I'm
	# reproducing it as best as I can, which is not much here.
	#
	# Original algorithm
	# void gray_encoder_add(inout float3 state, float x, uint radix, bool cont=true) {
	# 	x = (int(state.x) & 1) ? radix-1-x : x;
	# 	state.x  = state.x*radix + round(x);
	# 	state.yz = cont && round(x) == float2(0, radix-1) ? state.yz : x-round(x);
	# }

	# HLSL special rules :
	# * Boolean operators (&&, ||, ?:) don't short-circuit.
	# * Boolean operators work component-wise, and will basically
	#   be used as selectors.
	#
	#   Meaning that :
	#   	bool2(true, false) ? float2(-15,-50) : float2( 15, 50);
	#   will returns float2(-15, 50).
	#
	#   Basically :
	#   * -15 from (-15,-50) is selected since the first bool is true
	#   * 50 from (15, 50) is selected since the second bool is false
	# * == has more priority than &&
	# * && has more priority than ?:

	# Ugh...

	var state_is_odd:bool = bool(int(state.x) & 1)
	value = radix - 1 - value if state_is_odd else value
	var rounded_value:float = round(value)

	var current_state_yz:Vector2 = Vector2(state.y, state.z)
	var current_state_x:float = state.x

	# Radix is color_tile_radix here (value : 3)
	# So Vector2(0, radix-1) is equal to Vector2(0, 2)
	var continuation_select:Vector2i = Vector2i(continuation, continuation)
	var zero_two_select:Vector2i = hlsl_vector2_equal(
		Vector2(rounded_value, rounded_value),
		Vector2(0, radix-1)
	)
	var selectors:Vector2i = hlsl_vector2_and(
		continuation_select, zero_two_select
	)

	var value_minus_round:float = value - rounded_value
	var state_yz:Vector2 = hlsl_vector2_ternary(
		selectors,
		current_state_yz,
		Vector2(value_minus_round, value_minus_round)
	)

	var state_after:Vector3 = Vector3(
		current_state_x * radix + rounded_value,
		state_yz[0],
		state_yz[1]
	)

	log_func(
		"gray_decoder_add",
		{
			"state": state,
			"value": value,
			"radix": radix,
			"result": state_after,
		})

	return state_after

func _sm_decode_video_snorm(tiles:ColorTile):
	var state:Vector3 = Vector3(0,0,0)
	for color in range(0, color_tile_len):
		var current_color:Color = tiles.data[color]
		current_color *= (color_tile_radix - 1)
		state = _sm_gray_decoder_add(state, current_color.g, color_tile_radix)
		state = _sm_gray_decoder_add(state, current_color.r, color_tile_radix)
		state = _sm_gray_decoder_add(state, current_color.b, color_tile_radix)

	# ???
	var tile_max_value:float = tile_pow - 1
	var half_tile_max_value:float = tile_max_value / 2
	var sum:float = _sm_gray_decoder_sum(
		Vector3(
			state.x - half_tile_max_value,
			state.y,
			state.z
		)
	)
	var result = sum / half_tile_max_value
	log_func(
		"_sm_decode_video_snorm",
		{
			"tiles": tiles,
			"result": result
		}
	)
	return result

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

	var uv_colors = [
		[Vector2(0.00625, 0.744444), Color(1,1,1,1)],
		[Vector2(0.01875, 0.744444), Color(1.0, 0.12844, 0.30196, 0.00)]
	]

	var default_color:Color = Color(0,0,0,0)
	for uv_color in uv_colors:
		if uv.is_equal_approx(uv_color[0]):
			return uv_color[1]
	return default_color

func linear_to_gamma(linear_color:Color) -> Color:
	return linear_color

class ColorTile:
	var data:PackedColorArray = PackedColorArray()
	func _init():
		data.resize(2)
	func _to_string():
		return str(data)



func log_func(method_name:String, variables:Dictionary):
	print("[%s]" % [method_name])
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
	_sm_decode_video_snorm(c)

var provided_uv:Vector2 = Vector2(0.00937, 0.73889)

func _frag():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	print(tile_count)
	_sm_sample_snorm(provided_uv)
	pass # Replace with function body.
