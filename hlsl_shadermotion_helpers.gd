extends Node

class_name ShaderMotionHLSLHelpers

const color_tile_radix:int = 3
const color_tile_len:int   = 2
const video_resolution:Vector2i = Vector2i(80, 45)
const tile_count:Vector2i = video_resolution / Vector2i(color_tile_len, 1)
const tile_pow:float = pow(color_tile_radix, color_tile_len * 3)

static func hlsl_vector2_ternary(
	condition:Vector2,
	if_values:Vector2,
	else_values:Vector2
) -> Vector2:
	return Vector2(
		if_values.x if bool(condition.x) else else_values.x,
		if_values.y if bool(condition.y) else else_values.y
	)

static func hlsl_vector3_ternary(
	condition:Vector3,
	if_values:Vector3,
	else_values:Vector3
) -> Vector3:
	return Vector3(
		if_values.x if bool(condition.x) else else_values.x,
		if_values.y if bool(condition.y) else else_values.y,
		if_values.z if bool(condition.z) else else_values.z
	)

static func hlsl_vector2_and(
	condition_a:Vector2i,
	condition_b:Vector2i
) -> Vector2i:
	return Vector2i(
		(condition_a.x & condition_b.x),
		(condition_a.y & condition_b.y)
	)

static func hlsl_vector2_equal(
	vector_a:Vector2,
	vector_b:Vector2
) -> Vector2i:
	return Vector2i(
		vector_a.x == vector_b.x,
		vector_a.y == vector_b.y
	)

static func hlsl_max_vec2(vector_a:Vector2, vector_b:Vector2) ->  Vector2:
	return Vector2(
		maxf(vector_a.x, vector_b.x),
		maxf(vector_a.y, vector_b.y)
	)

static func _hlsl_lerp_vec2(a:Vector2, b:Vector2, weight:Vector2):
	return Vector2(
		lerpf(a.x, b.x, weight.x),
		lerpf(a.y, b.y, weight.y)
	)

static func log_func(method_name:String, variables:Dictionary):
	return
	print("[%s]" % [method_name])
	for var_name in variables:
		var current_variable = variables[var_name]
		print("\t%s : %s" % [var_name, str(current_variable)])

static func _sm_gray_decoder_add(
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

static func _sm_gray_decoder_sum(
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

static func shadermotion_decode_tiles(tiles:Array):
	var state:Vector3 = Vector3(0,0,0)
	for color in range(0, color_tile_len):
		var current_color:Color = tiles[color]
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

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
