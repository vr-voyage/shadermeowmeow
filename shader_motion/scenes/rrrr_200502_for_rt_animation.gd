extends Node3D

@export var animation_player:AnimationPlayer
@export var skeleton:Skeleton3D

# Called when the node enters the scene tree for the first time.
func _ready():
	print(skeleton.find_bone("POUIOPOSAURUS"))
	if animation_player == null:
		printerr("animation_player on %s is not setup correctly" % name)
		set_process(false)
		return
	

func play_animation():
	animation_player.play("RESET")
	animation_player.play("real_time_frames")

func get_bones_ids(bones_names:Array[String]) -> PackedInt32Array:
	var relations:PackedInt32Array = PackedInt32Array()
	relations.resize(len(bones_names))
	for bone in range(len(bones_names)):
		relations[bone] = skeleton.find_bone(bones_names[bone])
	return relations

func apply_shadermotion_movements(bones_id:PackedInt32Array, hips_position:Vector3, bones_rotations:Array[Quaternion]):
	var hips_id:int = bones_id[ShaderMotionHelpers.MecanimBodyBone.Hips]
	if hips_id < 0:
		printerr("No hips bone known on this skeleton !")
		return
	skeleton.reset_bone_poses()
	skeleton.set_bone_pose_position(hips_id, hips_position)
	for bone in range(ShaderMotionHelpers.MecanimBodyBone.LastBone):
		var bone_id = bones_id[bone]
		if bone_id < 0:
			printerr("Invalid bone_id for bone %d" % bone)
			continue
		var bone_rotation:Quaternion = bones_rotations[bone]
		if bone_rotation == NodeHelpers.invalid_quaternion:
			continue
		skeleton.set_bone_pose_rotation(bone_id, bones_rotations[bone])
