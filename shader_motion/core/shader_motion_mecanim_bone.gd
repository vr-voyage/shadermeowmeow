extends VBoxContainer

@export var tile_analyzer_scene:PackedScene 

@export var tiles_analysis_container:Container

@export var bone_name_label:Label

@export var bone_swingtwist_label:Label
@export var bone_swingtwist_signed_label:Label
@export var bone_rotation_label:Label
@export var bone_signs_label:Label

@export var bone_hips_position_low_label:Label
@export var bone_hips_position_high_label:Label
@export var bone_hips_position_label:Label
@export var bone_hips_scale_label:Label

@export var invalid_data_warning_label:Label

var analyzed_bone:ShaderMotionHelpers.MecanimBodyBone = ShaderMotionHelpers.MecanimBodyBone.LastBone
var analyzed_bone_name:String = ""
var decoded_swing_twist:Vector3 = NodeHelpers.invalid_vector
var related_bone_signs:Vector3 = NodeHelpers.invalid_vector
var computed_swing_twist:Vector3 = NodeHelpers.invalid_vector
var computed_rotation:Quaternion = NodeHelpers.invalid_quaternion

var shader_position_high:Vector3 = NodeHelpers.invalid_vector
var shader_position_low:Vector3 = NodeHelpers.invalid_vector

var computed_scale:float = NAN
var computed:bool = false

func _compute_standard_bone_data(
	parsed_angles:PackedFloat64Array,
	bone:ShaderMotionHelpers.MecanimBodyBone
):
	var swing_twist:Vector3 = NodeHelpers.float_array_to_vector3(parsed_angles)
	var bone_signs:Vector3 = ShaderMotionHelpers.human_axes[bone].limit_sign
	var signed_swing_twist:Vector3 = swing_twist * bone_signs

	var equivalent_rotation:Quaternion = ShaderMotionHelpers.swing_twist(signed_swing_twist)

	decoded_swing_twist = swing_twist
	related_bone_signs = bone_signs
	computed_swing_twist = signed_swing_twist
	computed_rotation = equivalent_rotation

	computed = true

func _show_computed_data():
	bone_name_label.text = "%s (%s)" % [analyzed_bone_name, str(analyzed_bone)]
	if computed:
		if analyzed_bone != ShaderMotionHelpers.MecanimBodyBone.Hips:
			bone_swingtwist_label.text = str(decoded_swing_twist)
			bone_swingtwist_signed_label.text = str(computed_swing_twist)
			bone_signs_label.text = str(related_bone_signs)
			bone_rotation_label.text = str(computed_rotation)
		else:
			var scene_tree:SceneTree = get_tree()
			scene_tree.call_group("StandardBoneGroup", "set_visible", false)
			scene_tree.call_group("HipsBoneGroup", "set_visible", true)
			bone_hips_position_high_label.text = str(shader_position_high)
			bone_hips_position_low_label.text = str(shader_position_low)
			bone_hips_position_label.text = str(computed_swing_twist)
			bone_rotation_label.text = str(computed_rotation)
			bone_hips_scale_label.text = str(computed_scale)

func _unity_look_rotation_case_a(
	vector_a:Vector3,
	vector_b:Vector3,
	vector_c:Vector3,
	bx_cy_az:float
) -> Quaternion:
#	var num = (float)Mathf.Sqrt(num8 + 1f);
#	quaternion.w = num * 0.5f;
#	num = 0.5f / num;
#	quaternion.x = (vector_c_z - vector_a_y) * num;
#	quaternion.y = (vector_a_x - vector_b_z) * num;
#	quaternion.z = (vector_b_y - vector_c_x) * num;
#	return quaternion;
	var unknown:float = sqrt(bx_cy_az + 1)
	var xyz_operand:float = 0.5 / unknown
	return Quaternion(
		(vector_c.z - vector_a.y) * xyz_operand,
		(vector_a.x - vector_b.z) * xyz_operand,
		(vector_b.y - vector_c.x) * xyz_operand,
		unknown * 0.5
	)

func _unity_look_rotation_case_b(
	vector_a:Vector3,
	vector_b:Vector3,
	vector_c:Vector3
) -> Quaternion:
#	var num7 = (float)Mathf.Sqrt(((1f + vector_b_x) - vector_c_y) - vector_a_z);
#	var num4 = 0.5f / num7;
#	quaternion.x = 0.5f * num7;
#	quaternion.y = (vector_b_y + vector_c_x) * num4;
#	quaternion.z = (vector_b_z + vector_a_x) * num4;
#	quaternion.w = (vector_c_z - vector_a_y) * num4;
	var x_operand = sqrt(1 + vector_b.x - vector_c.y - vector_a.z)
	var yzw_operand = 0.5 / x_operand
	return Quaternion(
		0.5 * x_operand,
		(vector_b.y + vector_c.x) * yzw_operand,
		(vector_b.z + vector_a.x) * yzw_operand,
		(vector_c.z - vector_a.y) * yzw_operand
	)

func _unity_look_rotation_case_c(
	vector_a:Vector3,
	vector_b:Vector3,
	vector_c:Vector3
) -> Quaternion:
#	var num6 = (float)Mathf.Sqrt(((1f + vector_c_y) - vector_b_x) - vector_a_z);
#	var num3 = 0.5f / num6;
#	quaternion.x = (vector_c_x + vector_b_y) * num3;
#	quaternion.y = 0.5f * num6;
#	quaternion.z = (vector_a_y + vector_c_z) * num3;
#	quaternion.w = (vector_a_x - vector_b_z) * num3;
	var y_operand = sqrt(1 + vector_c.y - vector_b.x - vector_a.z)
	var xzw_operand = 0.5 / y_operand
	return Quaternion(
		(vector_c.z + vector_b.y) * xzw_operand,
		0.5 * y_operand,
		(vector_a.y + vector_c.z) * xzw_operand,
		(vector_a.x - vector_b.z) * xzw_operand
	)

func _unity_look_rotation_case_d(
	vector_a:Vector3,
	vector_b:Vector3,
	vector_c:Vector3
) -> Quaternion:
#	var num5 = (float)Mathf.Sqrt(((1f + vector_a_z) - vector_b_x) - vector_c_y);
#	var num2 = 0.5f / num5;
#	quaternion.x = (vector_a_x + vector_b_z) * num2;
#	quaternion.y = (vector_a_y + vector_c_z) * num2;
#	quaternion.z = 0.5f * num5;
#	quaternion.w = (vector_b_y - vector_c_x) * num2;
	var z_operand:float = sqrt(1 + vector_a.z - vector_b.x - vector_c.y)
	var xyw_operand:float = 0.5 / z_operand
	return Quaternion(
		(vector_a.x + vector_b.z) * xyw_operand,
		(vector_a.y + vector_c.z) * xyw_operand,
		0.5 * z_operand,
		(vector_b.y - vector_c.x)  * xyw_operand
	)

func _unity_look_rotation(
	forward_vector:Vector3,
	up_vector:Vector3
) -> Quaternion:
	# Going deeper into the incomprehensible copy-pasta
	# This time it's an implementation of Unity Quaternion.LookRotation
	# coming from
	# https://answers.unity.com/questions/467614/what-is-the-source-code-of-quaternionlookrotation.html
	# And since I'm dumb, I figure out way too late that vector_a, b and c form
	# a 3x3 Matrix actually.

	var forward_normalized = forward_vector.normalized()
	var vector_a:Vector3 = forward_normalized.normalized() # Yes, it does it twice
	var vector_b:Vector3 = up_vector.cross(forward_normalized).normalized()
	#var vector_b:Vector3 = forward_normalized.cross(up_vector).normalized()
	var vector_c:Vector3 = vector_a.cross(vector_b)

	var bx_cy_az:float = vector_b.x + vector_c.y + vector_a.z
	if bx_cy_az > 0:
		return _unity_look_rotation_case_a(vector_a, vector_b, vector_c, bx_cy_az)
	elif ((vector_b.x >= vector_c.y) and (vector_b.x >= vector_a.z)):
		return _unity_look_rotation_case_b(vector_a, vector_b, vector_c)
	elif vector_c.y > vector_a.z:
		return _unity_look_rotation_case_c(vector_a, vector_b, vector_c)

	return _unity_look_rotation_case_d(vector_a, vector_b, vector_c)

const position_scale:int = 2
const _unity_vector_up:Vector3 = Vector3(0,1,0)
const _unity_vector_forward:Vector3 = Vector3(0,0,1)

# These are actually variables set in Awake()
# on the Unity version
const tile_radix:int  = 3
const tile_height:int = 1
const tile_depth:int  = 3
const tile_width:int  = 2
const tile_pow:int    = int(pow(tile_radix, tile_width * tile_height * tile_depth))

func _compute_hips_motion(vectors:PackedVector3Array):
	if vectors == null or len(vectors) < 4:
		printerr("Invalid Hips motion data !")
		return

	var position_high:Vector3 = vectors[0]
	var position_low:Vector3 = vectors[1]

	var decoded_position:Vector3 = Vector3(
		ShaderMotionHelpers.decode_video_float(position_high.x, position_low.x, tile_pow),
		ShaderMotionHelpers.decode_video_float(position_high.y, position_low.y, tile_pow),
		ShaderMotionHelpers.decode_video_float(position_high.z, position_low.z, tile_pow)
	)

	var rotation_vectors:PackedVector3Array = ShaderMotionHelpers.orthogonalize(
		vectors[2], vectors[3]
	)

	var up_vector = rotation_vectors[0]
	var forward_vector = rotation_vectors[1]

	if not forward_vector.length() > 0:
		up_vector = _unity_vector_up
		forward_vector = _unity_vector_forward

	var look_rotation:Quaternion = _unity_look_rotation(forward_vector, up_vector)

	#var motion = {
	#	"position": decoded_position * position_scale,
	#	"rotation": look_rotation,
	#	"scale": up_vector.length() / forward_vector.length()
	#}
	#print(motion)

	shader_position_high = position_high
	shader_position_low = position_low
	computed_swing_twist = decoded_position * position_scale
	computed_rotation = look_rotation
	computed_scale = up_vector.length() / forward_vector.length()
	computed = true

func _compute_hips_bone_data(parsed_angles:PackedFloat64Array):
	var decoded_vectors:PackedVector3Array = NodeHelpers.float_array_to_packed_vector3(parsed_angles)
	
	#invalid_data_warning_label.visible = true
	_compute_hips_motion(decoded_vectors)

func _decode_tiles(pixels:SpriteFrames, bone_tiles:Array, raw:bool = false) -> PackedFloat64Array:
	var parsed_angles:PackedFloat64Array = PackedFloat64Array()
	for shader_motion_tile in bone_tiles:
		# -1 indices return 0
		if shader_motion_tile < 0:
			parsed_angles.append(0)
			continue

		var analyzer_scene = tile_analyzer_scene.instantiate()
		tiles_analysis_container.add_child(analyzer_scene)
		# FIXME Find a better name...
		analyzer_scene.show_slot(pixels, shader_motion_tile)
		if not raw:
			parsed_angles.append(analyzer_scene.shader_motion_decoded_angle)
		else:
			parsed_angles.append(analyzer_scene.shader_motion_value)
		
	return parsed_angles

func analyze_bone_from(
	pixels:SpriteFrames,
	bone:ShaderMotionHelpers.MecanimBodyBone,
	bone_name:String
):
	if bone < ShaderMotionHelpers.MecanimBodyBone.Hips or bone >= ShaderMotionHelpers.MecanimBodyBone.LastBone:
		printerr("Invalid bone %d" % [int(bone)])
		return

	if not ShaderMotionHelpers.mecanim_bone_tiles.has(bone):
		printerr("Bone %s is not referenced" % [str(bone)])
		return

	var bone_tiles = ShaderMotionHelpers.mecanim_bone_tiles[bone]

	if bone_tiles == null:
		printerr("No tiles for bone %s" % [str(bone)])
		return

	analyzed_bone = bone
	analyzed_bone_name = bone_name
	var parsed_angles:PackedFloat64Array = _decode_tiles(
		pixels, bone_tiles,
		bone == ShaderMotionHelpers.MecanimBodyBone.Hips)

	if bone != ShaderMotionHelpers.MecanimBodyBone.Hips:
		_compute_standard_bone_data(parsed_angles, bone)
	else:
		_compute_hips_bone_data(parsed_angles)

	_show_computed_data()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body. 

func _on_panel_input(input_event:InputEvent):
	if input_event is InputEventMouseButton:
		var mouse_button_event = input_event as InputEventMouseButton
		if mouse_button_event.button_index == 1 and not mouse_button_event.pressed:
			_toggle_analysis()

func _toggle_analysis():
	tiles_analysis_container.visible = !tiles_analysis_container.visible
