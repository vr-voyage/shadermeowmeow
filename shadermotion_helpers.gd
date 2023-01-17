extends Control

class_name ShaderMotionHelpers

enum FrameBlock {
	HIPS_POSITION_HIGH,
	HIPS_POSITION_LOW,
	HIPS_SCALED_Y_AXIS,
	HIPS_SCALED_Z_AXIS,
	SPINE,
	CHEST,
	UPPER_CHEST,
	NECK,
	HEAD,
	LEFT_UPPER_LEG,
	RIGHT_UPPER_LEG,
	LEFT_LOWER_LEG,
	RIGHT_LOWER_LEG,
	LEFT_FOOT,
	RIGHT_FOOT,
	LEFT_SHOULDER,
	RIGHT_SHOULDER,
	LEFT_UPPER_ARM,
	RIGHT_UPPER_ARM,
	LEFT_LOWER_ARM,
	RIGHT_LOWER_ARM,
	LEFT_HAND,
	RIGHT_HAND,
	LEFT_TOES,
	RIGHT_TOES,
	LEFT_EYE,
	RIGHT_EYE,
	BLENDSHAPE_LIPSYNC,
	BLENDSHAPE_BLINK,
	BLENDSHAPE_EMOTION,
	LEFT_THUMB_PROXIMAL,
	LEFT_THUMB_INTERMEDIATE,
	LEFT_THUMB_DISTAL,
	LEFT_INDEX_PROXIMAL,
	LEFT_INDEX_INTERMEDIATE,
	LEFT_INDEX_DISTAL,
	LEFT_MIDDLE_PROXIMAL,
	LEFT_MIDDLE_INTERMEDIATE,
	LEFT_MIDDLE_DISTAL,
	LEFT_RING_PROXIMAL,
	LEFT_RING_INTERMEDIATE,
	LEFT_RING_DISTAL,
	LEFT_LITTLE_PROXIMAL,
	LEFT_LITTLE_INTERMEDIATE,
	LEFT_LITTLE_DISTAL,
	RIGHT_THUMB_PROXIMAL,
	RIGHT_THUMB_INTERMEDIATE,
	RIGHT_THUMB_DISTAL,
	RIGHT_INDEX_PROXIMAL,
	RIGHT_INDEX_INTERMEDIATE,
	RIGHT_INDEX_DISTAL,
	RIGHT_MIDDLE_PROXIMAL,
	RIGHT_MIDDLE_INTERMEDIATE,
	RIGHT_MIDDLE_DISTAL,
	RIGHT_RING_PROXIMAL,
	RIGHT_RING_INTERMEDIATE,
	RIGHT_RING_DISTAL,
	RIGHT_LITTLE_PROXIMAL,
	RIGHT_LITTLE_INTERMEDIATE,
	RIGHT_LITTLE_DISTAL,
	PRIVATE_USE
}

const block_tiles = {
	FrameBlock.HIPS_POSITION_HIGH: [0, 1, 2],
	FrameBlock.HIPS_POSITION_LOW: [3, 4, 5],
	FrameBlock.HIPS_SCALED_Y_AXIS: [6, 7, 8],
	FrameBlock.HIPS_SCALED_Z_AXIS: [9, 10, 11],
	FrameBlock.SPINE: [12, 13, 14],
	FrameBlock.CHEST: [15, 16, 17],
	FrameBlock.UPPER_CHEST: [18, 19, 20],
	FrameBlock.NECK: [21, 22, 23],
	FrameBlock.HEAD: [24, 25, 26],
	FrameBlock.LEFT_UPPER_LEG: [27, 28, 29],
	FrameBlock.RIGHT_UPPER_LEG: [30, 31, 32],
	FrameBlock.LEFT_LOWER_LEG: [33, 34, 35],
	FrameBlock.RIGHT_LOWER_LEG: [36, 37, 38],
	FrameBlock.LEFT_FOOT: [39, 40, 41],
	FrameBlock.RIGHT_FOOT: [42, 43, 44],
	FrameBlock.LEFT_SHOULDER: [45, 46, 47],
	FrameBlock.RIGHT_SHOULDER: [48, 49, 50],
	FrameBlock.LEFT_UPPER_ARM: [51, 52, 53],
	FrameBlock.RIGHT_UPPER_ARM: [54, 55, 56],
	FrameBlock.LEFT_LOWER_ARM: [57, 58, 59],
	FrameBlock.RIGHT_LOWER_ARM: [60, 61, 62],
	FrameBlock.LEFT_HAND: [63, 64, 65],
	FrameBlock.RIGHT_HAND: [66, 67, 68],
	FrameBlock.LEFT_TOES: [69],
	FrameBlock.RIGHT_TOES: [70],
	FrameBlock.LEFT_EYE: [71, 72],
	FrameBlock.RIGHT_EYE: [73, 74],
	FrameBlock.LEFT_THUMB_PROXIMAL: [90, 91],
	FrameBlock.LEFT_THUMB_INTERMEDIATE: [92],
	FrameBlock.LEFT_THUMB_DISTAL: [93],
	FrameBlock.LEFT_INDEX_PROXIMAL: [94, 95],
	FrameBlock.LEFT_INDEX_INTERMEDIATE: [96],
	FrameBlock.LEFT_INDEX_DISTAL: [97],
	FrameBlock.LEFT_MIDDLE_PROXIMAL: [98, 99],
	FrameBlock.LEFT_MIDDLE_INTERMEDIATE: [100],
	FrameBlock.LEFT_MIDDLE_DISTAL: [101],
	FrameBlock.LEFT_RING_PROXIMAL: [102, 103],
	FrameBlock.LEFT_RING_INTERMEDIATE: [104],
	FrameBlock.LEFT_RING_DISTAL: [105],
	FrameBlock.LEFT_LITTLE_PROXIMAL: [106, 107],
	FrameBlock.LEFT_LITTLE_INTERMEDIATE: [108],
	FrameBlock.LEFT_LITTLE_DISTAL: [109],
	FrameBlock.RIGHT_THUMB_PROXIMAL: [110, 111],
	FrameBlock.RIGHT_THUMB_INTERMEDIATE: [112],
	FrameBlock.RIGHT_THUMB_DISTAL: [113],
	FrameBlock.RIGHT_INDEX_PROXIMAL: [114, 115],
	FrameBlock.RIGHT_INDEX_INTERMEDIATE: [116],
	FrameBlock.RIGHT_INDEX_DISTAL: [117],
	FrameBlock.RIGHT_MIDDLE_PROXIMAL: [118, 119],
	FrameBlock.RIGHT_MIDDLE_INTERMEDIATE: [120],
	FrameBlock.RIGHT_MIDDLE_DISTAL: [121],
	FrameBlock.RIGHT_RING_PROXIMAL: [122, 123],
	FrameBlock.RIGHT_RING_INTERMEDIATE: [124],
	FrameBlock.RIGHT_RING_DISTAL: [125],
	FrameBlock.RIGHT_LITTLE_PROXIMAL: [126, 127],
	FrameBlock.RIGHT_LITTLE_INTERMEDIATE: [128],
	FrameBlock.RIGHT_LITTLE_DISTAL: [129],
	FrameBlock.BLENDSHAPE_LIPSYNC: [80, 81],
	FrameBlock.BLENDSHAPE_BLINK: [82, 83],
	FrameBlock.BLENDSHAPE_EMOTION: [88, 89],
	FrameBlock.PRIVATE_USE: [77, 78, 79, 84, 85, 86, 87, 130, 131, 132, 133, 134],
}

# Shameless copy of Unity HumanBodyBones
enum MecanimBodyBone
{
	# This is the Hips bone
	Hips = 0,

	# This is the Left Upper Leg bone
	LeftUpperLeg = 1,
	# This is the Right Upper Leg bone
	RightUpperLeg = 2,
	# This is the Left Knee bone
	LeftLowerLeg = 3,
	# This is the Right Knee bone
	RightLowerLeg = 4,
	# This is the Left Ankle bone
	LeftFoot = 5,
	# This is the Right Ankle bone
	RightFoot = 6,

	# This is the first Spine bone
	Spine = 7,
	# This is the Chest bone
	Chest = 8,

	Neck = 9,
	# This is the Head bone
	Head = 10,

	# This is the Left Shoulder bone
	LeftShoulder = 11,
	# This is the Right Shoulder bone
	RightShoulder = 12,
	# This is the Left Upper Arm bone
	LeftUpperArm = 13,
	# This is the Right Upper Arm bone
	RightUpperArm = 14,
	# This is the Left Elbow bone
	LeftLowerArm = 15,
	# This is the Right Elbow bone
	RightLowerArm = 16,
	# This is the Left Wrist bone
	LeftHand = 17,
	# This is the Right Wrist bone
	RightHand = 18,

	# This is the Left Toes bone
	LeftToes = 19,
	# This is the Right Toes bone
	RightToes = 20,

	# This is the Left Eye bone
	LeftEye = 21,
	# This is the Right Eye bone
	RightEye = 22,
	# This is the Jaw bone
	Jaw = 23,

	LeftThumbProximal = 24,
	LeftThumbIntermediate = 25,
	LeftThumbDistal = 26,

	LeftIndexProximal = 27,
	LeftIndexIntermediate = 28,
	LeftIndexDistal = 29,

	LeftMiddleProximal = 30,
	LeftMiddleIntermediate = 31,
	LeftMiddleDistal = 32,

	LeftRingProximal = 33,
	LeftRingIntermediate = 34,
	LeftRingDistal = 35,

	LeftLittleProximal = 36,
	LeftLittleIntermediate = 37,
	LeftLittleDistal = 38,

	RightThumbProximal = 39,
	RightThumbIntermediate = 40,
	RightThumbDistal = 41,

	RightIndexProximal = 42,
	RightIndexIntermediate = 43,
	RightIndexDistal = 44,

	RightMiddleProximal = 45,
	RightMiddleIntermediate = 46,
	RightMiddleDistal = 47,

	RightRingProximal = 48,
	RightRingIntermediate = 49,
	RightRingDistal = 50,

	RightLittleProximal = 51,
	RightLittleIntermediate = 52,
	RightLittleDistal = 53,
	UpperChest = 54,
	LastBone = 55
}

const AnimatorMuscleName = [
  "Spine Front-Back",
  "Spine Left-Right",
  "Spine Twist Left-Right",
  "Chest Front-Back",
  "Chest Left-Right",
  "Chest Twist Left-Right",
  "UpperChest Front-Back",
  "UpperChest Left-Right",
  "UpperChest Twist Left-Right",
  "Neck Nod Down-Up",
  "Neck Tilt Left-Right",
  "Neck Turn Left-Right",
  "Head Nod Down-Up",
  "Head Tilt Left-Right",
  "Head Turn Left-Right",
  "Left Eye Down-Up",
  "Left Eye In-Out",
  "Right Eye Down-Up",
  "Right Eye In-Out",
  "Jaw Close",
  "Jaw Left-Right",
  "Left Upper Leg Front-Back",
  "Left Upper Leg In-Out",
  "Left Upper Leg Twist In-Out",
  "Left Lower Leg Stretch",
  "Left Lower Leg Twist In-Out",
  "Left Foot Up-Down",
  "Left Foot Twist In-Out",
  "Left Toes Up-Down",
  "Right Upper Leg Front-Back",
  "Right Upper Leg In-Out",
  "Right Upper Leg Twist In-Out",
  "Right Lower Leg Stretch",
  "Right Lower Leg Twist In-Out",
  "Right Foot Up-Down",
  "Right Foot Twist In-Out",
  "Right Toes Up-Down",
  "Left Shoulder Down-Up",
  "Left Shoulder Front-Back",
  "Left Arm Down-Up",
  "Left Arm Front-Back",
  "Left Arm Twist In-Out",
  "Left Forearm Stretch",
  "Left Forearm Twist In-Out",
  "Left Hand Down-Up",
  "Left Hand In-Out",
  "Right Shoulder Down-Up",
  "Right Shoulder Front-Back",
  "Right Arm Down-Up",
  "Right Arm Front-Back",
  "Right Arm Twist In-Out",
  "Right Forearm Stretch",
  "Right Forearm Twist In-Out",
  "Right Hand Down-Up",
  "Right Hand In-Out",
  "LeftHand.Thumb.1 Stretched",
  "LeftHand.Thumb.Spread",
  "LeftHand.Thumb.2 Stretched",
  "LeftHand.Thumb.3 Stretched",
  "LeftHand.Index.1 Stretched",
  "LeftHand.Index.Spread",
  "LeftHand.Index.2 Stretched",
  "LeftHand.Index.3 Stretched",
  "LeftHand.Middle.1 Stretched",
  "LeftHand.Middle.Spread",
  "LeftHand.Middle.2 Stretched",
  "LeftHand.Middle.3 Stretched",
  "LeftHand.Ring.1 Stretched",
  "LeftHand.Ring.Spread",
  "LeftHand.Ring.2 Stretched",
  "LeftHand.Ring.3 Stretched",
  "LeftHand.Little.1 Stretched",
  "LeftHand.Little.Spread",
  "LeftHand.Little.2 Stretched",
  "LeftHand.Little.3 Stretched",
  "RightHand.Thumb.1 Stretched",
  "RightHand.Thumb.Spread",
  "RightHand.Thumb.2 Stretched",
  "RightHand.Thumb.3 Stretched",
  "RightHand.Index.1 Stretched",
  "RightHand.Index.Spread",
  "RightHand.Index.2 Stretched",
  "RightHand.Index.3 Stretched",
  "RightHand.Middle.1 Stretched",
  "RightHand.Middle.Spread",
  "RightHand.Middle.2 Stretched",
  "RightHand.Middle.3 Stretched",
  "RightHand.Ring.1 Stretched",
  "RightHand.Ring.Spread",
  "RightHand.Ring.2 Stretched",
  "RightHand.Ring.3 Stretched",
  "RightHand.Little.1 Stretched",
  "RightHand.Little.Spread",
  "RightHand.Little.2 Stretched",
  "RightHand.Little.3 Stretched",
];

enum MecanimMuscle {
	INVALID = -1,
	SPINE_FRONT_BACK = 0,
	SPINE_LEFT_RIGHT,
	SPINE_TWIST_LEFT_RIGHT,
	CHEST_FRONT_BACK,
	CHEST_LEFT_RIGHT,
	CHEST_TWIST_LEFT_RIGHT,
	UPPERCHEST_FRONT_BACK,
	UPPERCHEST_LEFT_RIGHT,
	UPPERCHEST_TWIST_LEFT_RIGHT,
	NECK_NOD_DOWN_UP,
	NECK_TILT_LEFT_RIGHT,
	NECK_TURN_LEFT_RIGHT,
	HEAD_NOD_DOWN_UP,
	HEAD_TILT_LEFT_RIGHT,
	HEAD_TURN_LEFT_RIGHT,
	LEFT_EYE_DOWN_UP,
	LEFT_EYE_IN_OUT,
	RIGHT_EYE_DOWN_UP,
	RIGHT_EYE_IN_OUT,
	JAW_CLOSE,
	JAW_LEFT_RIGHT,
	LEFT_UPPER_LEG_FRONT_BACK,
	LEFT_UPPER_LEG_IN_OUT,
	LEFT_UPPER_LEG_TWIST_IN_OUT,
	LEFT_LOWER_LEG_STRETCH,
	LEFT_LOWER_LEG_TWIST_IN_OUT,
	LEFT_FOOT_UP_DOWN,
	LEFT_FOOT_TWIST_IN_OUT,
	LEFT_TOES_UP_DOWN,
	RIGHT_UPPER_LEG_FRONT_BACK,
	RIGHT_UPPER_LEG_IN_OUT,
	RIGHT_UPPER_LEG_TWIST_IN_OUT,
	RIGHT_LOWER_LEG_STRETCH,
	RIGHT_LOWER_LEG_TWIST_IN_OUT,
	RIGHT_FOOT_UP_DOWN,
	RIGHT_FOOT_TWIST_IN_OUT,
	RIGHT_TOES_UP_DOWN,
	LEFT_SHOULDER_DOWN_UP,
	LEFT_SHOULDER_FRONT_BACK,
	LEFT_ARM_DOWN_UP,
	LEFT_ARM_FRONT_BACK,
	LEFT_ARM_TWIST_IN_OUT,
	LEFT_FOREARM_STRETCH,
	LEFT_FOREARM_TWIST_IN_OUT,
	LEFT_HAND_DOWN_UP,
	LEFT_HAND_IN_OUT,
	RIGHT_SHOULDER_DOWN_UP,
	RIGHT_SHOULDER_FRONT_BACK,
	RIGHT_ARM_DOWN_UP,
	RIGHT_ARM_FRONT_BACK,
	RIGHT_ARM_TWIST_IN_OUT,
	RIGHT_FOREARM_STRETCH,
	RIGHT_FOREARM_TWIST_IN_OUT,
	RIGHT_HAND_DOWN_UP,
	RIGHT_HAND_IN_OUT,
	LEFTHAND_THUMB_1_STRETCHED,
	LEFTHAND_THUMB_SPREAD,
	LEFTHAND_THUMB_2_STRETCHED,
	LEFTHAND_THUMB_3_STRETCHED,
	LEFTHAND_INDEX_1_STRETCHED,
	LEFTHAND_INDEX_SPREAD,
	LEFTHAND_INDEX_2_STRETCHED,
	LEFTHAND_INDEX_3_STRETCHED,
	LEFTHAND_MIDDLE_1_STRETCHED,
	LEFTHAND_MIDDLE_SPREAD,
	LEFTHAND_MIDDLE_2_STRETCHED,
	LEFTHAND_MIDDLE_3_STRETCHED,
	LEFTHAND_RING_1_STRETCHED,
	LEFTHAND_RING_SPREAD,
	LEFTHAND_RING_2_STRETCHED,
	LEFTHAND_RING_3_STRETCHED,
	LEFTHAND_LITTLE_1_STRETCHED,
	LEFTHAND_LITTLE_SPREAD,
	LEFTHAND_LITTLE_2_STRETCHED,
	LEFTHAND_LITTLE_3_STRETCHED,
	RIGHTHAND_THUMB_1_STRETCHED,
	RIGHTHAND_THUMB_SPREAD,
	RIGHTHAND_THUMB_2_STRETCHED,
	RIGHTHAND_THUMB_3_STRETCHED,
	RIGHTHAND_INDEX_1_STRETCHED,
	RIGHTHAND_INDEX_SPREAD,
	RIGHTHAND_INDEX_2_STRETCHED,
	RIGHTHAND_INDEX_3_STRETCHED,
	RIGHTHAND_MIDDLE_1_STRETCHED,
	RIGHTHAND_MIDDLE_SPREAD,
	RIGHTHAND_MIDDLE_2_STRETCHED,
	RIGHTHAND_MIDDLE_3_STRETCHED,
	RIGHTHAND_RING_1_STRETCHED,
	RIGHTHAND_RING_SPREAD,
	RIGHTHAND_RING_2_STRETCHED,
	RIGHTHAND_RING_3_STRETCHED,
	RIGHTHAND_LITTLE_1_STRETCHED,
	RIGHTHAND_LITTLE_SPREAD,
	RIGHTHAND_LITTLE_2_STRETCHED,
	RIGHTHAND_LITTLE_3_STRETCHED,
	COUNT
}

enum MuscleMinMax
{
	MIN,
	MAX
}

const mecanim_muscle_limits = {
	MecanimMuscle.SPINE_FRONT_BACK: [-40, 40],
	MecanimMuscle.SPINE_LEFT_RIGHT: [-40, 40],
	MecanimMuscle.SPINE_TWIST_LEFT_RIGHT: [-40, 40],
	MecanimMuscle.CHEST_FRONT_BACK: [-40, 40],
	MecanimMuscle.CHEST_LEFT_RIGHT: [-40, 40],
	MecanimMuscle.CHEST_TWIST_LEFT_RIGHT: [-40, 40],
	MecanimMuscle.UPPERCHEST_FRONT_BACK: [-20, 20],
	MecanimMuscle.UPPERCHEST_LEFT_RIGHT: [-20, 20],
	MecanimMuscle.UPPERCHEST_TWIST_LEFT_RIGHT: [-20, 20],
	MecanimMuscle.NECK_NOD_DOWN_UP: [-40, 40],
	MecanimMuscle.NECK_TILT_LEFT_RIGHT: [-40, 40],
	MecanimMuscle.NECK_TURN_LEFT_RIGHT: [-40, 40],
	MecanimMuscle.HEAD_NOD_DOWN_UP: [-40, 40],
	MecanimMuscle.HEAD_TILT_LEFT_RIGHT: [-40, 40],
	MecanimMuscle.HEAD_TURN_LEFT_RIGHT: [-40, 40],
	MecanimMuscle.LEFT_EYE_DOWN_UP: [-10, 15],
	MecanimMuscle.LEFT_EYE_IN_OUT: [-20, 20],
	MecanimMuscle.RIGHT_EYE_DOWN_UP: [-10, 15],
	MecanimMuscle.RIGHT_EYE_IN_OUT: [-20, 20],
	MecanimMuscle.JAW_CLOSE: [-10, 10],
	MecanimMuscle.JAW_LEFT_RIGHT: [-10, 10],
	MecanimMuscle.LEFT_UPPER_LEG_FRONT_BACK: [-90, 50],
	MecanimMuscle.LEFT_UPPER_LEG_IN_OUT: [-60, 60],
	MecanimMuscle.LEFT_UPPER_LEG_TWIST_IN_OUT: [-60, 60],
	MecanimMuscle.LEFT_LOWER_LEG_STRETCH: [-80, 80],
	MecanimMuscle.LEFT_LOWER_LEG_TWIST_IN_OUT: [-90, 90],
	MecanimMuscle.LEFT_FOOT_UP_DOWN: [-50, 50],
	MecanimMuscle.LEFT_FOOT_TWIST_IN_OUT: [-30, 30],
	MecanimMuscle.LEFT_TOES_UP_DOWN: [-50, 50],
	MecanimMuscle.RIGHT_UPPER_LEG_FRONT_BACK: [-90, 50],
	MecanimMuscle.RIGHT_UPPER_LEG_IN_OUT: [-60, 60],
	MecanimMuscle.RIGHT_UPPER_LEG_TWIST_IN_OUT: [-60, 60],
	MecanimMuscle.RIGHT_LOWER_LEG_STRETCH: [-80, 80],
	MecanimMuscle.RIGHT_LOWER_LEG_TWIST_IN_OUT: [-90, 90],
	MecanimMuscle.RIGHT_FOOT_UP_DOWN: [-50, 50],
	MecanimMuscle.RIGHT_FOOT_TWIST_IN_OUT: [-30, 30],
	MecanimMuscle.RIGHT_TOES_UP_DOWN: [-50, 50],
	MecanimMuscle.LEFT_SHOULDER_DOWN_UP: [-15, 30],
	MecanimMuscle.LEFT_SHOULDER_FRONT_BACK: [-15, 15],
	MecanimMuscle.LEFT_ARM_DOWN_UP: [-60, 100],
	MecanimMuscle.LEFT_ARM_FRONT_BACK: [-100, 100],
	MecanimMuscle.LEFT_ARM_TWIST_IN_OUT: [-90, 90],
	MecanimMuscle.LEFT_FOREARM_STRETCH: [-80, 80],
	MecanimMuscle.LEFT_FOREARM_TWIST_IN_OUT: [-90, 90],
	MecanimMuscle.LEFT_HAND_DOWN_UP: [-80, 80],
	MecanimMuscle.LEFT_HAND_IN_OUT: [-40, 40],
	MecanimMuscle.RIGHT_SHOULDER_DOWN_UP: [-15, 30],
	MecanimMuscle.RIGHT_SHOULDER_FRONT_BACK: [-15, 15],
	MecanimMuscle.RIGHT_ARM_DOWN_UP: [-60, 100],
	MecanimMuscle.RIGHT_ARM_FRONT_BACK: [-100, 100],
	MecanimMuscle.RIGHT_ARM_TWIST_IN_OUT: [-90, 90],
	MecanimMuscle.RIGHT_FOREARM_STRETCH: [-80, 80],
	MecanimMuscle.RIGHT_FOREARM_TWIST_IN_OUT: [-90, 90],
	MecanimMuscle.RIGHT_HAND_DOWN_UP: [-80, 80],
	MecanimMuscle.RIGHT_HAND_IN_OUT: [-40, 40],
	MecanimMuscle.LEFTHAND_THUMB_1_STRETCHED: [-20, 20],
	MecanimMuscle.LEFTHAND_THUMB_SPREAD: [-25, 25],
	MecanimMuscle.LEFTHAND_THUMB_2_STRETCHED: [-40, 35],
	MecanimMuscle.LEFTHAND_THUMB_3_STRETCHED: [-40, 35],
	MecanimMuscle.LEFTHAND_INDEX_1_STRETCHED: [-50, 50],
	MecanimMuscle.LEFTHAND_INDEX_SPREAD: [-20, 20],
	MecanimMuscle.LEFTHAND_INDEX_2_STRETCHED: [-45, 45],
	MecanimMuscle.LEFTHAND_INDEX_3_STRETCHED: [-45, 45],
	MecanimMuscle.LEFTHAND_MIDDLE_1_STRETCHED: [-50, 50],
	MecanimMuscle.LEFTHAND_MIDDLE_SPREAD: [-7.5, 7.5],
	MecanimMuscle.LEFTHAND_MIDDLE_2_STRETCHED: [-45, 45],
	MecanimMuscle.LEFTHAND_MIDDLE_3_STRETCHED: [-45, 45],
	MecanimMuscle.LEFTHAND_RING_1_STRETCHED: [-50, 50],
	MecanimMuscle.LEFTHAND_RING_SPREAD: [-7.5, 7.5],
	MecanimMuscle.LEFTHAND_RING_2_STRETCHED: [-45, 45],
	MecanimMuscle.LEFTHAND_RING_3_STRETCHED: [-45, 45],
	MecanimMuscle.LEFTHAND_LITTLE_1_STRETCHED: [-50, 50],
	MecanimMuscle.LEFTHAND_LITTLE_SPREAD: [-20, 20],
	MecanimMuscle.LEFTHAND_LITTLE_2_STRETCHED: [-45, 45],
	MecanimMuscle.LEFTHAND_LITTLE_3_STRETCHED: [-45, 45],
	MecanimMuscle.RIGHTHAND_THUMB_1_STRETCHED: [-20, 20],
	MecanimMuscle.RIGHTHAND_THUMB_SPREAD: [-25, 25],
	MecanimMuscle.RIGHTHAND_THUMB_2_STRETCHED: [-40, 35],
	MecanimMuscle.RIGHTHAND_THUMB_3_STRETCHED: [-40, 35],
	MecanimMuscle.RIGHTHAND_INDEX_1_STRETCHED: [-50, 50],
	MecanimMuscle.RIGHTHAND_INDEX_SPREAD: [-20, 20],
	MecanimMuscle.RIGHTHAND_INDEX_2_STRETCHED: [-45, 45],
	MecanimMuscle.RIGHTHAND_INDEX_3_STRETCHED: [-45, 45],
	MecanimMuscle.RIGHTHAND_MIDDLE_1_STRETCHED: [-50, 50],
	MecanimMuscle.RIGHTHAND_MIDDLE_SPREAD: [-7.5, 7.5],
	MecanimMuscle.RIGHTHAND_MIDDLE_2_STRETCHED: [-45, 45],
	MecanimMuscle.RIGHTHAND_MIDDLE_3_STRETCHED: [-45, 45],
	MecanimMuscle.RIGHTHAND_RING_1_STRETCHED: [-50, 50],
	MecanimMuscle.RIGHTHAND_RING_SPREAD: [-7.5, 7.5],
	MecanimMuscle.RIGHTHAND_RING_2_STRETCHED: [-45, 45],
	MecanimMuscle.RIGHTHAND_RING_3_STRETCHED: [-45, 45],
	MecanimMuscle.RIGHTHAND_LITTLE_1_STRETCHED: [-50, 50],
	MecanimMuscle.RIGHTHAND_LITTLE_SPREAD: [-20, 20],
	MecanimMuscle.RIGHTHAND_LITTLE_2_STRETCHED: [-45, 45],
	MecanimMuscle.RIGHTHAND_LITTLE_3_STRETCHED: [-45, 45]
}

# Three values for 3 degrees of freedom
# Coming from Unity "MuscleFromBone(MecanimBodyBone, dofIndex)"
# Index 0 : X-Axis
# Index 1 : Y-Axis
# Index 2 : Z-Axis
const mecanim_bone_muscles = {
	MecanimBodyBone.Hips: [
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.INVALID, 1],
	],
	MecanimBodyBone.LeftUpperLeg: [
		[MecanimMuscle.LEFT_UPPER_LEG_TWIST_IN_OUT, 1],
		[MecanimMuscle.LEFT_UPPER_LEG_IN_OUT, 1],
		[MecanimMuscle.LEFT_UPPER_LEG_FRONT_BACK, 1],
	],
	MecanimBodyBone.RightUpperLeg: [
		[MecanimMuscle.RIGHT_UPPER_LEG_TWIST_IN_OUT, 1],
		[MecanimMuscle.RIGHT_UPPER_LEG_IN_OUT, 1],
		[MecanimMuscle.RIGHT_UPPER_LEG_FRONT_BACK, 1],
	],
	MecanimBodyBone.LeftLowerLeg: [
		[MecanimMuscle.LEFT_LOWER_LEG_TWIST_IN_OUT, 1],
		[MecanimMuscle.LEFT_UPPER_LEG_TWIST_IN_OUT, 1],
		[MecanimMuscle.LEFT_LOWER_LEG_STRETCH, 1],
	],
	MecanimBodyBone.RightLowerLeg: [
		[MecanimMuscle.RIGHT_LOWER_LEG_TWIST_IN_OUT, 1],
		[MecanimMuscle.RIGHT_UPPER_LEG_TWIST_IN_OUT, 1],
		[MecanimMuscle.RIGHT_LOWER_LEG_STRETCH, 1],
	],
	MecanimBodyBone.LeftFoot: [
		[MecanimMuscle.LEFT_LOWER_LEG_TWIST_IN_OUT, 1],
		[MecanimMuscle.LEFT_FOOT_TWIST_IN_OUT, 1],
		[MecanimMuscle.LEFT_FOOT_UP_DOWN, 1],
	],
	MecanimBodyBone.RightFoot: [
		[MecanimMuscle.RIGHT_LOWER_LEG_TWIST_IN_OUT, 1],
		[MecanimMuscle.RIGHT_FOOT_TWIST_IN_OUT, 1],
		[MecanimMuscle.RIGHT_FOOT_UP_DOWN, 1],
	],
	MecanimBodyBone.Spine: [
		[MecanimMuscle.SPINE_TWIST_LEFT_RIGHT, 1],
		[MecanimMuscle.SPINE_LEFT_RIGHT, 1],
		[MecanimMuscle.SPINE_FRONT_BACK, 1],
	],
	MecanimBodyBone.Chest: [
		[MecanimMuscle.CHEST_TWIST_LEFT_RIGHT, 1],
		[MecanimMuscle.CHEST_LEFT_RIGHT, 1],
		[MecanimMuscle.CHEST_FRONT_BACK, 1],
	],
	MecanimBodyBone.Neck: [
		[MecanimMuscle.NECK_TURN_LEFT_RIGHT, 1],
		[MecanimMuscle.NECK_TILT_LEFT_RIGHT, 1],
		[MecanimMuscle.NECK_NOD_DOWN_UP, 1],
	],
	MecanimBodyBone.Head: [
		[MecanimMuscle.HEAD_TURN_LEFT_RIGHT, 1],
		[MecanimMuscle.HEAD_TILT_LEFT_RIGHT, 1],
		[MecanimMuscle.HEAD_NOD_DOWN_UP, 1],
	],
	MecanimBodyBone.LeftShoulder: [
		[MecanimMuscle.LEFT_ARM_TWIST_IN_OUT, 1],
		[MecanimMuscle.LEFT_SHOULDER_FRONT_BACK, 1],
		[MecanimMuscle.LEFT_SHOULDER_DOWN_UP, 1],
	],
	MecanimBodyBone.RightShoulder: [
		[MecanimMuscle.RIGHT_ARM_TWIST_IN_OUT, 1],
		[MecanimMuscle.RIGHT_SHOULDER_FRONT_BACK, 1],
		[MecanimMuscle.RIGHT_SHOULDER_DOWN_UP, 1],
	],
	MecanimBodyBone.LeftUpperArm: [
		[MecanimMuscle.LEFT_ARM_TWIST_IN_OUT, 1],
		[MecanimMuscle.LEFT_ARM_FRONT_BACK, 1],
		[MecanimMuscle.LEFT_ARM_DOWN_UP, 1],
	],
	MecanimBodyBone.RightUpperArm: [
		[MecanimMuscle.RIGHT_ARM_TWIST_IN_OUT, 1],
		[MecanimMuscle.RIGHT_ARM_FRONT_BACK, 1],
		[MecanimMuscle.RIGHT_ARM_DOWN_UP, 1],
	],
	MecanimBodyBone.LeftLowerArm: [
		[MecanimMuscle.LEFT_FOREARM_TWIST_IN_OUT, 1],
		[MecanimMuscle.LEFT_ARM_TWIST_IN_OUT, -1],
		[MecanimMuscle.LEFT_FOREARM_STRETCH, 1],
	],
	MecanimBodyBone.RightLowerArm: [
		[MecanimMuscle.RIGHT_FOREARM_TWIST_IN_OUT, 1],
		[MecanimMuscle.RIGHT_ARM_TWIST_IN_OUT, -1],
		[MecanimMuscle.RIGHT_FOREARM_STRETCH, 1],
	],
	MecanimBodyBone.LeftHand: [
		[MecanimMuscle.LEFT_FOREARM_TWIST_IN_OUT, 1],
		[MecanimMuscle.LEFT_HAND_IN_OUT, 1],
		[MecanimMuscle.LEFT_HAND_DOWN_UP, 1],
	],
	MecanimBodyBone.RightHand: [
		[MecanimMuscle.RIGHT_FOREARM_TWIST_IN_OUT, 1],
		[MecanimMuscle.RIGHT_HAND_IN_OUT, 1],
		[MecanimMuscle.RIGHT_HAND_DOWN_UP, 1],
	],
	MecanimBodyBone.LeftToes: [
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.LEFT_FOOT_TWIST_IN_OUT, 1],
		[MecanimMuscle.LEFT_TOES_UP_DOWN, 1],
	],
	MecanimBodyBone.RightToes: [
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.RIGHT_FOOT_TWIST_IN_OUT, 1],
		[MecanimMuscle.RIGHT_TOES_UP_DOWN, 1],
	],
	MecanimBodyBone.LeftEye: [
		[MecanimMuscle.HEAD_TURN_LEFT_RIGHT, 1],
		[MecanimMuscle.LEFT_EYE_IN_OUT, 1],
		[MecanimMuscle.LEFT_EYE_DOWN_UP, 1],
	],
	MecanimBodyBone.RightEye: [
		[MecanimMuscle.HEAD_TURN_LEFT_RIGHT, 1],
		[MecanimMuscle.RIGHT_EYE_IN_OUT, 1],
		[MecanimMuscle.RIGHT_EYE_DOWN_UP, 1],
	],
	MecanimBodyBone.Jaw: [
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.JAW_LEFT_RIGHT, 1],
		[MecanimMuscle.JAW_CLOSE, 1],
	],
	MecanimBodyBone.LeftThumbProximal: [
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.LEFTHAND_THUMB_SPREAD, 1],
		[MecanimMuscle.LEFTHAND_THUMB_1_STRETCHED, 1],
	],
	MecanimBodyBone.LeftThumbIntermediate: [
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.LEFTHAND_THUMB_SPREAD, 1],
		[MecanimMuscle.LEFTHAND_THUMB_2_STRETCHED, 1],
	],
	MecanimBodyBone.LeftThumbDistal: [
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.LEFTHAND_THUMB_3_STRETCHED, 1],
	],
	MecanimBodyBone.LeftIndexProximal: [
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.LEFTHAND_INDEX_SPREAD, 1],
		[MecanimMuscle.LEFTHAND_INDEX_1_STRETCHED, 1],
	],
	MecanimBodyBone.LeftIndexIntermediate: [
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.LEFTHAND_INDEX_SPREAD, 1],
		[MecanimMuscle.LEFTHAND_INDEX_2_STRETCHED, 1],
	],
	MecanimBodyBone.LeftIndexDistal: [
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.LEFTHAND_INDEX_3_STRETCHED, 1],
	],
	MecanimBodyBone.LeftMiddleProximal: [
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.LEFTHAND_MIDDLE_SPREAD, 1],
		[MecanimMuscle.LEFTHAND_MIDDLE_1_STRETCHED, 1],
	],
	MecanimBodyBone.LeftMiddleIntermediate: [
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.LEFTHAND_MIDDLE_SPREAD, 1],
		[MecanimMuscle.LEFTHAND_MIDDLE_2_STRETCHED, 1],
	],
	MecanimBodyBone.LeftMiddleDistal: [
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.LEFTHAND_MIDDLE_3_STRETCHED, 1],
	],
	MecanimBodyBone.LeftRingProximal: [
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.LEFTHAND_RING_SPREAD, 1],
		[MecanimMuscle.LEFTHAND_RING_1_STRETCHED, 1],
	],
	MecanimBodyBone.LeftRingIntermediate: [
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.LEFTHAND_RING_SPREAD, 1],
		[MecanimMuscle.LEFTHAND_RING_2_STRETCHED, 1],
	],
	MecanimBodyBone.LeftRingDistal: [
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.LEFTHAND_RING_3_STRETCHED, 1],
	],
	MecanimBodyBone.LeftLittleProximal: [
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.LEFTHAND_LITTLE_SPREAD, 1],
		[MecanimMuscle.LEFTHAND_LITTLE_1_STRETCHED, 1],
	],
	MecanimBodyBone.LeftLittleIntermediate: [
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.LEFTHAND_LITTLE_SPREAD, 1],
		[MecanimMuscle.LEFTHAND_LITTLE_2_STRETCHED, 1],
	],
	MecanimBodyBone.LeftLittleDistal: [
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.LEFTHAND_LITTLE_3_STRETCHED, 1],
	],
	MecanimBodyBone.RightThumbProximal: [
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.RIGHTHAND_THUMB_SPREAD, 1],
		[MecanimMuscle.RIGHTHAND_THUMB_1_STRETCHED, 1],
	],
	MecanimBodyBone.RightThumbIntermediate: [
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.RIGHTHAND_THUMB_SPREAD, 1],
		[MecanimMuscle.RIGHTHAND_THUMB_2_STRETCHED, 1],
	],
	MecanimBodyBone.RightThumbDistal: [
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.RIGHTHAND_THUMB_3_STRETCHED, 1],
	],
	MecanimBodyBone.RightIndexProximal: [
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.RIGHTHAND_INDEX_SPREAD, 1],
		[MecanimMuscle.RIGHTHAND_INDEX_1_STRETCHED, 1],
	],
	MecanimBodyBone.RightIndexIntermediate: [
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.RIGHTHAND_INDEX_SPREAD, 1],
		[MecanimMuscle.RIGHTHAND_INDEX_2_STRETCHED, 1],
	],
	MecanimBodyBone.RightIndexDistal: [
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.RIGHTHAND_INDEX_3_STRETCHED, 1],
	],
	MecanimBodyBone.RightMiddleProximal: [
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.RIGHTHAND_MIDDLE_SPREAD, 1],
		[MecanimMuscle.RIGHTHAND_MIDDLE_1_STRETCHED, 1],
	],
	MecanimBodyBone.RightMiddleIntermediate: [
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.RIGHTHAND_MIDDLE_SPREAD, 1],
		[MecanimMuscle.RIGHTHAND_MIDDLE_2_STRETCHED, 1],
	],
	MecanimBodyBone.RightMiddleDistal: [
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.RIGHTHAND_MIDDLE_3_STRETCHED, 1],
	],
	MecanimBodyBone.RightRingProximal: [
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.RIGHTHAND_RING_SPREAD, 1],
		[MecanimMuscle.RIGHTHAND_RING_1_STRETCHED, 1],
	],
	MecanimBodyBone.RightRingIntermediate: [
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.RIGHTHAND_RING_SPREAD, 1],
		[MecanimMuscle.RIGHTHAND_RING_2_STRETCHED, 1],
	],
	MecanimBodyBone.RightRingDistal: [
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.RIGHTHAND_RING_3_STRETCHED, 1],
	],
	MecanimBodyBone.RightLittleProximal: [
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.RIGHTHAND_LITTLE_SPREAD, 1],
		[MecanimMuscle.RIGHTHAND_LITTLE_1_STRETCHED, 1],
	],
	MecanimBodyBone.RightLittleIntermediate: [
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.RIGHTHAND_LITTLE_SPREAD, 1],
		[MecanimMuscle.RIGHTHAND_LITTLE_2_STRETCHED, 1],
	],
	MecanimBodyBone.RightLittleDistal: [
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.INVALID, 1],
		[MecanimMuscle.RIGHTHAND_LITTLE_3_STRETCHED, 1],
	],
	MecanimBodyBone.UpperChest: [
		[MecanimMuscle.UPPERCHEST_TWIST_LEFT_RIGHT, 1],
		[MecanimMuscle.UPPERCHEST_LEFT_RIGHT, 1],
		[MecanimMuscle.UPPERCHEST_FRONT_BACK, 1],
	],
}

# Bone - Scale
const spread_mass_q = [
	[MecanimBodyBone.Spine, Vector3(20, -30, -30)],
	[MecanimBodyBone.Chest, Vector3(20, -20, -20)],
	[MecanimBodyBone.UpperChest, Vector3(10, -10, -10)]
]

func _strings_to_enum_names(strings:PackedStringArray) -> PackedStringArray:
	var names:PackedStringArray = PackedStringArray()
	var regex = RegEx.new()
	var ret:int = regex.compile("[ \\._-]")
	if ret != OK:
		printerr("[ShaderMotionHelpers] Could not compile Regex : %d" % ret)
		return names

	for i in range(0, len(strings)):
		var name_to_convert = strings[i]
		names.append(regex.sub(name_to_convert, "_", true).to_upper())
	return names

enum MuscleAxis {
	X,
	Y,
	Z
}

class HumanBodyPose:
	var muscles:PackedFloat64Array = PackedFloat64Array()
	var body_position:Vector3 = Vector3.ZERO
	var body_rotation:Quaternion = Quaternion.IDENTITY

# ???
static func swing_twist(euler_angles:Vector3):
	var only_yz = Vector3(0, euler_angles.y, euler_angles.z)
	# ... Magic values, magic operations leading to magic data...
	return (
		Quaternion(only_yz.normalized(), deg_to_rad(only_yz.length()))
		* Quaternion(Vector3(1,0,0), deg_to_rad(euler_angles.x)))

func _muscle_from_bone(mecanim_bone:MecanimBodyBone, muscle_axis:MuscleAxis):
	# FIXME
	# Improves the readability here.
	# The latest 0 retrieves the associated muscle.
	# 1 would retrieve an associated weight.
	return mecanim_bone_muscles[mecanim_bone][muscle_axis][0]

func _set_hips_position_rotation(pose:HumanBodyPose, hips_t:Vector3, hips_q:Quaternion, human_scale:float):
	var spread_q = Quaternion.IDENTITY
	for bone_and_scale in spread_mass_q:
		var mecanim_bone:MecanimBodyBone = bone_and_scale[0]
		var bone_scale:Vector3 = bone_and_scale[1]

		var swing_twist_value:Vector3 = Vector3(
			_muscle_from_bone(mecanim_bone, MuscleAxis.X) * bone_scale[MuscleAxis.X],
			_muscle_from_bone(mecanim_bone, MuscleAxis.Y) * bone_scale[MuscleAxis.Y],
			_muscle_from_bone(mecanim_bone, MuscleAxis.Z) * bone_scale[MuscleAxis.Z]
		)

		spread_q *= swing_twist(swing_twist_value)

	# In the original ShaderMotion, HumanPoser.cs uses
	# Quaternion.LookRotation(Vector3.right, Vector3.forward) which
	# evaluates to Quaternion(0.5,0.5,0.5,0.5).
	# In order to get the same value here, I'm using
	#   Quaternion(Basis.looking_at(Vector3.LEFT, Vector3.BACK))
	
	# t for ???
	var t = Quaternion(Basis.looking_at(Vector3.LEFT, Vector3.BACK))
	pose.body_position = hips_t / human_scale
	pose.body_rotation = hips_q * (t * spread_q * t.inverse())

# motion_data is supposed to contain motion information
# in a data structure that can be referenced through mecanim bones indices.

# swing_twists must be a data structure with swing/twists values
# referenced by Mecanim Bones.
# Meaning that swing_twists[MecanimBone.???] must not fail
func set_bones_swing_twists(pose:HumanBodyPose, swing_twists):

	pose.muscles.resize(MecanimMuscle.COUNT)
	pose.muscles.fill(0)
	for mecanim_bone in MecanimBodyBone:
		for axis in MuscleAxis:
			var muscle_and_weight = mecanim_bone_muscles[mecanim_bone][axis]

			var muscle:MecanimMuscle = muscle_and_weight[0]
			var weight:float = muscle_and_weight[1]

			if muscle >= 0:
				pose.muscles[muscle] += swing_twists[mecanim_bone][axis] * weight

	for mecanim_muscle in MecanimMuscle:
		var muscle_value:float = pose.muscles[mecanim_muscle]

		var muscle_limits:Array = mecanim_muscle_limits[mecanim_muscle]
		var divider:float
		if muscle_value >= 0:
			divider = muscle_limits[MuscleMinMax.MAX]
		else:
			divider = -muscle_limits[MuscleMinMax.MIN]

		pose.muscles[mecanim_muscle] = muscle_value / divider

func _test_swing_twist():
	var file_data = FileAccess.open("res://tests/data/swing_twist_tests.csv", FileAccess.READ)
	var csv_row:PackedStringArray = file_data.get_csv_line()
	while (len(csv_row) == 7):
		var test_angle:Vector3 = Vector3(
			float(csv_row[0]),
			float(csv_row[1]),
			float(csv_row[2]))
		var unity_result:Quaternion = Quaternion(
			float(csv_row[3]),
			float(csv_row[4]),
			float(csv_row[5]),
			float(csv_row[6]))
		var our_result:Quaternion = swing_twist(test_angle)
		csv_row = file_data.get_csv_line()
		printerr("swing_twist(%s) -> %s (Unity: %s)" % [test_angle, our_result, unity_result])
		printerr("Equal (roughly) ? %s" % str(our_result.is_equal_approx(unity_result)))
	pass

func _ready():
	var dict = JSON.parse_string("{ \"a\": null }")
	
	#printerr(Quaternion(Basis.looking_at(Vector3.LEFT, Vector3.BACK)))
	#_test_swing_twist()
#	var quat_a = Quaternion(Vector3(1,0,0), deg_to_rad(30))
#	print(quat_a)

#	printerr(len(MecanimMuscle))
#	var a = Vector3(0,1,2)
#	var b = a
#	b[0] = 15
#	printerr(a)
#	printerr(b)


