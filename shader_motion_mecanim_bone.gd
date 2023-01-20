extends VBoxContainer

@export var tile_analyzer_scene:PackedScene

@export var tiles_analysis_container:Container

@export var bone_name_label:Label
@export var bone_swingtwist_label:Label
@export var bone_swingtwist_signed_label:Label
@export var bone_rotation_label:Label
@export var bone_signs_label:Label

@export var invalid_data_warning_label:Label

var analyzed_bone:ShaderMotionHelpers.MecanimBodyBone = ShaderMotionHelpers.MecanimBodyBone.LastBone
var analyzed_bone_name:String = ""
var decoded_swing_twist:Vector3 = NodeHelpers.invalid_vector
var related_bone_signs:Vector3 = NodeHelpers.invalid_vector
var computed_swing_twist:Vector3 = NodeHelpers.invalid_vector
var computed_rotation:Quaternion = NodeHelpers.invalid_quaternion
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
		bone_swingtwist_label.text = str(decoded_swing_twist)
		bone_swingtwist_signed_label.text = str(computed_swing_twist)
		bone_signs_label.text = str(related_bone_signs)
		bone_rotation_label.text = str(computed_rotation)

func _compute_hips_bone_data(parsed_angles:PackedFloat64Array):
	invalid_data_warning_label.visible = true
	_compute_standard_bone_data(parsed_angles, ShaderMotionHelpers.MecanimBodyBone.Hips)

func _decode_tiles(pixels:SpriteFrames, bone_tiles:Array) -> PackedFloat64Array:
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
		parsed_angles.append(analyzer_scene.shader_motion_decoded_angle)
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
	var parsed_angles:PackedFloat64Array = _decode_tiles(pixels, bone_tiles)

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
