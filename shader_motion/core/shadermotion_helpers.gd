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

const mecanim_bone_tiles = {
	MecanimBodyBone.Hips: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
	MecanimBodyBone.LeftUpperLeg: [27, 28, 29],
	MecanimBodyBone.RightUpperLeg: [30, 31, 32],
	MecanimBodyBone.LeftLowerLeg: [33, 34, 35],
	MecanimBodyBone.RightLowerLeg: [36, 37, 38],
	MecanimBodyBone.LeftFoot: [39, 40, 41],
	MecanimBodyBone.RightFoot: [42, 43, 44],
	MecanimBodyBone.Spine: [12, 13, 14],
	MecanimBodyBone.Chest: [15, 16, 17],
	MecanimBodyBone.Neck: [21, 22, 23],
	MecanimBodyBone.Head: [24, 25, 26],
	MecanimBodyBone.LeftShoulder: [45, 46, 47],
	MecanimBodyBone.RightShoulder: [48, 49, 50],
	MecanimBodyBone.LeftUpperArm: [51, 52, 53],
	MecanimBodyBone.RightUpperArm: [54, 55, 56],
	MecanimBodyBone.LeftLowerArm: [57, 58, 59],
	MecanimBodyBone.RightLowerArm: [60, 61, 62],
	MecanimBodyBone.LeftHand: [63, 64, 65],
	MecanimBodyBone.RightHand: [66, 67, 68],
	MecanimBodyBone.LeftToes: [-1, -1, 69],
	MecanimBodyBone.RightToes: [-1, -1, 70],
	MecanimBodyBone.LeftEye: [-1, 71, 72],
	MecanimBodyBone.RightEye: [-1, 73, 74],
	MecanimBodyBone.LeftThumbProximal: [-1, 90, 91],
	MecanimBodyBone.LeftThumbIntermediate: [-1, -1, 92],
	MecanimBodyBone.LeftThumbDistal: [-1, -1, 93],
	MecanimBodyBone.LeftIndexProximal: [-1, 94, 95],
	MecanimBodyBone.LeftIndexIntermediate: [-1, -1, 96],
	MecanimBodyBone.LeftIndexDistal: [-1, -1, 97],
	MecanimBodyBone.LeftMiddleProximal: [-1, 98, 99],
	MecanimBodyBone.LeftMiddleIntermediate: [-1, -1, 100],
	MecanimBodyBone.LeftMiddleDistal: [-1, -1, 101],
	MecanimBodyBone.LeftRingProximal: [-1, 102, 103],
	MecanimBodyBone.LeftRingIntermediate: [-1, -1, 104],
	MecanimBodyBone.LeftRingDistal: [-1, -1, 105],
	MecanimBodyBone.LeftLittleProximal: [-1, 106, 107],
	MecanimBodyBone.LeftLittleIntermediate: [-1, -1, 108],
	MecanimBodyBone.LeftLittleDistal: [-1, -1, 109],
	MecanimBodyBone.RightThumbProximal: [-1, 110, 111],
	MecanimBodyBone.RightThumbIntermediate: [-1, -1, 112],
	MecanimBodyBone.RightThumbDistal: [-1, -1, 113],
	MecanimBodyBone.RightIndexProximal: [-1, 114, 115],
	MecanimBodyBone.RightIndexIntermediate: [-1, -1, 116],
	MecanimBodyBone.RightIndexDistal: [-1, -1, 117],
	MecanimBodyBone.RightMiddleProximal: [-1, 118, 119],
	MecanimBodyBone.RightMiddleIntermediate: [-1, -1, 120],
	MecanimBodyBone.RightMiddleDistal: [-1, -1, 121],
	MecanimBodyBone.RightRingProximal: [-1, 122, 123],
	MecanimBodyBone.RightRingIntermediate: [-1, -1, 124],
	MecanimBodyBone.RightRingDistal: [-1, -1, 125],
	MecanimBodyBone.RightLittleProximal: [-1, 126, 127],
	MecanimBodyBone.RightLittleIntermediate: [-1, -1, 128],
	MecanimBodyBone.RightLittleDistal: [-1, -1, 129],
	MecanimBodyBone.UpperChest: [18, 19, 20]
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

# This is just a random data dump from Unity.
# These values might be extremely tied to the specific model
# avatar Rig that was loaded in Unity.
const human_axes = {
#	hips is a bit special.
#	but hips has
#	bone.rotation * postQ == rotationMatrix * preQ
#
#	Normally.
#	bone.localRotation * postQ == preQ * SwingTwist(sign * degrees)
#
#	https://gitlab.com/lox9973/ShaderMotion/-/blob/master/Script/Common/HumanAxes.cs#L12
#	https://gitlab.com/lox9973/ShaderMotion/-/blob/master/Script/Common/Skeleton.cs#L43
#
# Post is bone roll orientation
# Pre is converting to bicycle pose

	MecanimBodyBone.Hips: {
		"pre_rotation": Quaternion(0.707107, 0, 0, 0.707107),
		"post_rotation": Quaternion(-0.03661, -0.706159, -0.03661, 0.706159),
		"limit_sign": Vector3(1, 1, 1)
	},
	MecanimBodyBone.LeftUpperLeg: {
		"pre_rotation": Quaternion(-1.538277e-7, 0, 0.895309, -0.445446),
		"post_rotation": Quaternion(0.708897, 0.705312, 0, -9.173525e-8),
		"limit_sign": Vector3(1, 1, 1)
	},
	MecanimBodyBone.RightUpperLeg: {
		"pre_rotation": Quaternion(-0, 0, 0.89531, -0.445444),
		"post_rotation": Quaternion(0.708895, 0.705314, -0, -0),
		"limit_sign": Vector3(-1, -1, 1)
	},
	MecanimBodyBone.LeftLowerLeg: {
		"pre_rotation": Quaternion(-0.99777, -0.06675, 0, -0),
		"post_rotation": Quaternion(-0.703807, -0.710391, 0, -0),
		"limit_sign": Vector3(1, -1, -1)
	},
	MecanimBodyBone.RightLowerLeg: {
		"pre_rotation": Quaternion(-0.99777, -0.066747, -0, -0),
		"post_rotation": Quaternion(-0.70381, -0.710389, -0, -0),
		"limit_sign": Vector3(-1, 1, -1)
	},
	MecanimBodyBone.LeftFoot: {
		"pre_rotation": Quaternion(-0.698167, -0.715935, 0, -0),
		"post_rotation": Quaternion(-0.714741, -0.69939, 0, -0),
		"limit_sign": Vector3(1, 1, 1)
	},
	MecanimBodyBone.RightFoot: {
		"pre_rotation": Quaternion(-0.698167, -0.715935, 0, -0),
		"post_rotation": Quaternion(-0.714741, -0.69939, 0, -0),
		"limit_sign": Vector3(-1, -1, 1)
	},
	MecanimBodyBone.Spine: {
		"pre_rotation": Quaternion(0.798239, 0.602342, -0, 0),
		"post_rotation": Quaternion(0.732742, 0.680506, -0, 0),
		"limit_sign": Vector3(1, 1, 1)
	},
	MecanimBodyBone.Chest: {
		"pre_rotation": Quaternion(-0.679783, -0.733413, -0, -0),
		"post_rotation": Quaternion(0, 0, 0.999906, -0.013728),
		"limit_sign": Vector3(1, 1, 1)
	},
	MecanimBodyBone.Neck: {
		"pre_rotation": Quaternion(0, 0, 0.99318, 0.116589),
		"post_rotation": Quaternion(-0.688814, -0.724939, 0, -0),
		"limit_sign": Vector3(1, 1, 1)
	},
	MecanimBodyBone.Head: {
		"pre_rotation": Quaternion(-0.769553, -0.638583, 0, 0),
		"post_rotation": Quaternion(-0.706172, -0.70804, 0, 0),
		"limit_sign": Vector3(1, 1, 1)
	},
	MecanimBodyBone.LeftShoulder: {
		"pre_rotation": Quaternion(0.551825, 0.438697, 0.440558, -0.555826),
		"post_rotation": Quaternion(0.493272, 0.49327, -0.506641, -0.506639),
		"limit_sign": Vector3(1, 1, -1)
	},
	MecanimBodyBone.RightShoulder: {
		"pre_rotation": Quaternion(-0.55579, 0.440602, 0.438743, 0.55179),
		"post_rotation": Quaternion(-0.506641, -0.506641, 0.49327, 0.49327),
		"limit_sign": Vector3(-1, 1, 1)
	},
	MecanimBodyBone.LeftUpperArm: {
		"pre_rotation": Quaternion(0.466266, 0.49242, -0.698724, -0.227823),
		"post_rotation": Quaternion(0.493089, 0.493089, -0.506817, -0.506816),
		"limit_sign": Vector3(1, 1, -1)
	},
	MecanimBodyBone.RightUpperArm: {
		"pre_rotation": Quaternion(-0.227777, -0.698767, 0.492358, 0.46629),
		"post_rotation": Quaternion(-0.506817, -0.506817, 0.493089, 0.493089),
		"limit_sign": Vector3(-1, 1, 1)
	},
	MecanimBodyBone.LeftLowerArm: {
		"pre_rotation": Quaternion(-0.014063, -0.000857, -0.996034, -0.087848),
		"post_rotation": Quaternion(-0.009706, -0.009707, -0.706575, -0.707505),
		"limit_sign": Vector3(1, 1, -1)
	},
	MecanimBodyBone.RightLowerArm: {
		"pre_rotation": Quaternion(-0.087847, -0.996034, -0.000842, -0.014054),
		"post_rotation": Quaternion(-0.707505, -0.706575, -0.009706, -0.009707),
		"limit_sign": Vector3(-1, 1, 1)
	},
	MecanimBodyBone.LeftHand: {
		"pre_rotation": Quaternion(0.493418, 0.49276, -0.506488, -0.507145),
		"post_rotation": Quaternion(0.498167, 0.501821, -0.497521, -0.502472),
		"limit_sign": Vector3(1, 1, -1)
	},
	MecanimBodyBone.RightHand: {
		"pre_rotation": Quaternion(-0.507146, -0.506487, 0.49276, 0.493418),
		"post_rotation": Quaternion(-0.501804, -0.498194, 0.501154, 0.49884),
		"limit_sign": Vector3(-1, 1, 1)
	},
	MecanimBodyBone.LeftToes: {
		"pre_rotation": Quaternion(0.010855, 0.999941, -0, 0),
		"post_rotation": Quaternion(0, 0.707107, 0, 0.707107),
		"limit_sign": Vector3(1, 1, 1)
	},
	MecanimBodyBone.RightToes: {
		"pre_rotation": Quaternion(0.010855, 0.999941, -0, 0),
		"post_rotation": Quaternion(0, 0.707107, 0, 0.707107),
		"limit_sign": Vector3(-1, -1, 1)
	},
	MecanimBodyBone.LeftEye: {
		"pre_rotation": Quaternion(0, 0, 0.999999, -0.001321),
		"post_rotation": Quaternion(0, 0, 0.999987, 0.005208),
		"limit_sign": Vector3(-1, 1, -1)
	},
	MecanimBodyBone.RightEye: {
		"pre_rotation": Quaternion(0, 0, 0.999999, -0.001321),
		"post_rotation": Quaternion(0, 0, 0.999987, 0.005208),
		"limit_sign": Vector3(1, -1, -1)
	},
	MecanimBodyBone.Jaw: {
		"pre_rotation": Quaternion(0, 0, 0, 1),
		"post_rotation": Quaternion(0, 0, 0, 1),
		"limit_sign": Vector3(1, 1, 1)
	},
	MecanimBodyBone.LeftThumbProximal: {
		"pre_rotation": Quaternion(0.082888, -0.119088, -0.948627, -0.281168),
		"post_rotation": Quaternion(0.049636, 0.061558, -0.690337, -0.719154),
		"limit_sign": Vector3(1, -1, 1)
	},
	MecanimBodyBone.LeftThumbIntermediate: {
		"pre_rotation": Quaternion(0.015854, 0.071953, -0.513928, -0.854663),
		"post_rotation": Quaternion(0.036813, 0.066408, -0.696017, -0.713999),
		"limit_sign": Vector3(1, -1, 1)
	},
	MecanimBodyBone.LeftThumbDistal: {
		"pre_rotation": Quaternion(0.016913, 0.066312, -0.543185, -0.83682),
		"post_rotation": Quaternion(0.051237, 0.02272, -0.714849, -0.697029),
		"limit_sign": Vector3(1, -1, 1)
	},
	MecanimBodyBone.LeftIndexProximal: {
		"pre_rotation": Quaternion(0.583848, 0.359439, -0.675595, -0.271104),
		"post_rotation": Quaternion(0.499013, 0.501091, -0.497307, -0.502572),
		"limit_sign": Vector3(-1, -1, -1)
	},
	MecanimBodyBone.LeftIndexIntermediate: {
		"pre_rotation": Quaternion(0.627522, 0.329651, -0.610862, -0.352694),
		"post_rotation": Quaternion(0.499736, 0.500264, -0.500264, -0.499736),
		"limit_sign": Vector3(-1, -1, -1)
	},
	MecanimBodyBone.LeftIndexDistal: {
		"pre_rotation": Quaternion(0.632768, 0.319906, -0.630223, -0.31636),
		"post_rotation": Quaternion(0.507655, 0.492226, -0.492225, -0.507655),
		"limit_sign": Vector3(-1, -1, -1)
	},
	MecanimBodyBone.LeftMiddleProximal: {
		"pre_rotation": Quaternion(0.612631, 0.338819, -0.647897, -0.30019),
		"post_rotation": Quaternion(0.498385, 0.501599, -0.498544, -0.501462),
		"limit_sign": Vector3(-1, -1, -1)
	},
	MecanimBodyBone.LeftMiddleIntermediate: {
		"pre_rotation": Quaternion(0.622304, 0.338035, -0.61984, -0.338037),
		"post_rotation": Quaternion(0.499851, 0.500149, -0.500146, -0.499854),
		"limit_sign": Vector3(-1, -1, -1)
	},
	MecanimBodyBone.LeftMiddleDistal: {
		"pre_rotation": Quaternion(0.632289, 0.319201, -0.630709, -0.31706),
		"post_rotation": Quaternion(0.502899, 0.497084, -0.49708, -0.502902),
		"limit_sign": Vector3(-1, -1, -1)
	},
	MecanimBodyBone.LeftRingProximal: {
		"pre_rotation": Quaternion(0.647603, 0.299221, -0.614464, -0.336914),
		"post_rotation": Quaternion(0.498375, 0.501641, -0.498003, -0.501968),
		"limit_sign": Vector3(1, 1, -1)
	},
	MecanimBodyBone.LeftRingIntermediate: {
		"pre_rotation": Quaternion(0.621233, 0.33774, -0.618959, -0.341893),
		"post_rotation": Quaternion(0.5, 0.5, -0.5, -0.5),
		"limit_sign": Vector3(1, 1, -1)
	},
	MecanimBodyBone.LeftRingDistal: {
		"pre_rotation": Quaternion(0.631503, 0.318126, -0.631503, -0.318126),
		"post_rotation": Quaternion(0.496197, 0.503774, -0.503778, -0.496194),
		"limit_sign": Vector3(1, 1, -1)
	},
	MecanimBodyBone.LeftLittleProximal: {
		"pre_rotation": Quaternion(0.640208, 0.309193, -0.600381, -0.366164),
		"post_rotation": Quaternion(0.485161, 0.514411, -0.514414, -0.485157),
		"limit_sign": Vector3(1, 1, -1)
	},
	MecanimBodyBone.LeftLittleIntermediate: {
		"pre_rotation": Quaternion(0.611049, 0.328106, -0.651315, -0.307822),
		"post_rotation": Quaternion(0.481859, 0.517506, -0.517505, -0.481859),
		"limit_sign": Vector3(1, 1, -1)
	},
	MecanimBodyBone.LeftLittleDistal: {
		"pre_rotation": Quaternion(0.609809, 0.330406, -0.65247, -0.305366),
		"post_rotation": Quaternion(0.48289, 0.516544, -0.516544, -0.48289),
		"limit_sign": Vector3(1, 1, -1)
	},
	MecanimBodyBone.RightThumbProximal: {
		"pre_rotation": Quaternion(0.280896, 0.948593, 0.120172, -0.082623),
		"post_rotation": Quaternion(-0.719129, -0.690357, 0.061561, 0.049706),
		"limit_sign": Vector3(-1, -1, -1)
	},
	MecanimBodyBone.RightThumbIntermediate: {
		"pre_rotation": Quaternion(0.8546, 0.513953, -0.072509, -0.015928),
		"post_rotation": Quaternion(-0.713962, -0.696055, 0.066458, 0.036724),
		"limit_sign": Vector3(-1, -1, -1)
	},
	MecanimBodyBone.RightThumbDistal: {
		"pre_rotation": Quaternion(0.836787, 0.54319, -0.066629, -0.017107),
		"post_rotation": Quaternion(-0.69698, -0.7149, 0.023063, 0.051041),
		"limit_sign": Vector3(-1, -1, -1)
	},
	MecanimBodyBone.RightIndexProximal: {
		"pre_rotation": Quaternion(0.270355, 0.67603, -0.358522, -0.584254),
		"post_rotation": Quaternion(-0.502578, -0.497303, 0.501023, 0.499081),
		"limit_sign": Vector3(1, -1, 1)
	},
	MecanimBodyBone.RightIndexIntermediate: {
		"pre_rotation": Quaternion(0.352633, 0.610926, -0.329636, -0.627503),
		"post_rotation": Quaternion(-0.499703, -0.500296, 0.5003, 0.4997),
		"limit_sign": Vector3(1, -1, 1)
	},
	MecanimBodyBone.RightIndexDistal: {
		"pre_rotation": Quaternion(0.31634, 0.630266, -0.31993, -0.632723),
		"post_rotation": Quaternion(-0.507624, -0.492258, 0.492262, 0.50762),
		"limit_sign": Vector3(1, -1, 1)
	},
	MecanimBodyBone.RightMiddleProximal: {
		"pre_rotation": Quaternion(0.299312, 0.648432, -0.337972, -0.612962),
		"post_rotation": Quaternion(-0.501353, -0.498651, 0.501615, 0.498372),
		"limit_sign": Vector3(1, -1, 1)
	},
	MecanimBodyBone.RightMiddleIntermediate: {
		"pre_rotation": Quaternion(0.338002, 0.619848, -0.337988, -0.62234),
		"post_rotation": Quaternion(-0.499861, -0.500139, 0.500136, 0.499864),
		"limit_sign": Vector3(1, -1, 1)
	},
	MecanimBodyBone.RightMiddleDistal: {
		"pre_rotation": Quaternion(0.317062, 0.630698, -0.31919, -0.632304),
		"post_rotation": Quaternion(-0.502909, -0.497073, 0.49707, 0.502913),
		"limit_sign": Vector3(1, -1, 1)
	},
	MecanimBodyBone.RightRingProximal: {
		"pre_rotation": Quaternion(0.33601, 0.614913, -0.298396, -0.648026),
		"post_rotation": Quaternion(-0.501885, -0.498084, 0.501618, 0.498401),
		"limit_sign": Vector3(-1, 1, 1)
	},
	MecanimBodyBone.RightRingIntermediate: {
		"pre_rotation": Quaternion(0.341852, 0.618979, -0.3377, -0.621257),
		"post_rotation": Quaternion(-0.5, -0.5, 0.5, 0.5),
		"limit_sign": Vector3(-1, 1, 1)
	},
	MecanimBodyBone.RightRingDistal: {
		"pre_rotation": Quaternion(0.318126, 0.631503, -0.318126, -0.631503),
		"post_rotation": Quaternion(-0.496196, -0.503775, 0.503775, 0.496196),
		"limit_sign": Vector3(-1, 1, 1)
	},
	MecanimBodyBone.RightLittleProximal: {
		"pre_rotation": Quaternion(0.365314, 0.600791, -0.308397, -0.640693),
		"post_rotation": Quaternion(-0.485159, -0.514413, 0.514413, 0.485159),
		"limit_sign": Vector3(-1, 1, 1)
	},
	MecanimBodyBone.RightLittleIntermediate: {
		"pre_rotation": Quaternion(0.307822, 0.651314, -0.328105, -0.61105),
		"post_rotation": Quaternion(-0.481859, -0.517506, 0.517505, 0.481859),
		"limit_sign": Vector3(-1, 1, 1)
	},
	MecanimBodyBone.RightLittleDistal: {
		"pre_rotation": Quaternion(0.305365, 0.65247, -0.330406, -0.609809),
		"post_rotation": Quaternion(-0.482891, -0.516542, 0.516542, 0.482891),
		"limit_sign": Vector3(-1, 1, 1)
	},
	MecanimBodyBone.UpperChest: {
		"pre_rotation": Quaternion(-0.679783, -0.733413, -0, -0),
		"post_rotation": Quaternion(0, 0, 0.999906, -0.013728),
		"limit_sign": Vector3(1, 1, 1)
	}
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
static func swing_twist(euler_angles:Vector3) -> Quaternion:
	var only_yz = Vector3(0, euler_angles.y, euler_angles.z)
	# ... Magic values, magic operations leading to magic data...
	return (
		Quaternion(only_yz.normalized(), deg_to_rad(only_yz.length()))
		* Quaternion(Vector3(1,0,0), deg_to_rad(euler_angles.x)))

static func _muscle_from_bone(
	mecanim_bone:MecanimBodyBone,
	muscle_axis:MuscleAxis
) -> float:
	# FIXME
	# Improves the readability here.
	# The latest 0 retrieves the associated muscle.
	# 1 would retrieve an associated weight.
	return mecanim_bone_muscles[mecanim_bone][muscle_axis][0]

static func pose_set_hips_position_rotation(
	_pose_muscles:PackedFloat64Array,
	hips_t:Vector3,
	hips_q:Quaternion,
	human_scale:float
) -> Dictionary:

	var spread_q = Quaternion.IDENTITY
	for bone_and_scale in spread_mass_q:
		var mecanim_bone:MecanimBodyBone = bone_and_scale[0]
		var bone_scale:Vector3 = bone_and_scale[1]

		var swing_twist_value:Vector3 = Vector3(
			_muscle_from_bone(mecanim_bone, MuscleAxis.X) * bone_scale[MuscleAxis.X],
			_muscle_from_bone(mecanim_bone, MuscleAxis.Y) * bone_scale[MuscleAxis.Y],
			_muscle_from_bone(mecanim_bone, MuscleAxis.Z) * bone_scale[MuscleAxis.Z]
		)

		spread_q *= ShaderMotionHelpers.swing_twist(swing_twist_value)

	# In the original ShaderMotion, HumanPoser.cs uses
	# Quaternion.LookRotation(Vector3.right, Vector3.forward) which
	# evaluates to Quaternion(0.5,0.5,0.5,0.5).
	# In order to get the same value here, I'm using
	#   Quaternion(Basis.looking_at(Vector3.LEFT, Vector3.BACK))
	
	# t for ???
	var t = Quaternion(Basis.looking_at(Vector3.LEFT, Vector3.BACK))
	return {
		"body_position": hips_t / human_scale,
		"body_rotation": hips_q * (t * spread_q * t.inverse())
	}

# motion_data is supposed to contain motion information
# in a data structure that can be referenced through mecanim bones indices.

# swing_twists must be a data structure with swing/twists values
# referenced by Mecanim Bones.
# Meaning that swing_twists[MecanimBone.???] must not fail
static func pose_set_bone_swing_twists(
	pose_muscles:PackedFloat64Array,
	swing_twists:Array
):

	pose_muscles.resize(MecanimMuscle.COUNT)
	pose_muscles.fill(0)
	for bone in MecanimBodyBone:
		var bone_related_muscles:Array = mecanim_bone_muscles[bone]
		var bone_related_swingtwist:Vector3 = swing_twists[bone].swing_twist
		for axis in MuscleAxis:
			var axis_info:Array = bone_related_muscles[axis]

			var muscle:MecanimMuscle = axis_info[0]
			var weight:float = axis_info[1]

			if muscle != MecanimMuscle.INVALID:
				pose_muscles[muscle] += bone_related_swingtwist[axis] * weight

	for muscle in MecanimMuscle:
#		var muscle_value:float = pose_muscles[muscle]

		var muscle_limits:Array[float] = mecanim_muscle_limits[muscle]
		var muscle_limit_min:float = muscle_limits[0]
		var muscle_limit_max:float = muscle_limits[1]
		var current_muscle_value:float = pose_muscles[muscle]

		if current_muscle_value >= 0:
			pose_muscles[muscle] = current_muscle_value / muscle_limit_max
		else:
			pose_muscles[muscle] = current_muscle_value / -muscle_limit_min

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
		var our_result:Quaternion = ShaderMotionHelpers.swing_twist(test_angle)
		csv_row = file_data.get_csv_line()
		printerr("swing_twist(%s) -> %s (Unity: %s)" % [test_angle, our_result, unity_result])
		printerr("Equal (roughly) ? %s" % str(our_result.is_equal_approx(unity_result)))
	pass

static func shadermotion_tile_rect(
	tile_index:int, adjacent:int,
	tiles_per_column:int = 45,
	tile_width:int = 24,
	tile_height:int = 24) -> Rect2:
	var block_column:int = round(tile_index / tiles_per_column)
	var block_row:int = tile_index % tiles_per_column
	var block_x:int = block_column * (tile_width * 2)
	var block_y:int = block_row
	var x:int = block_x if adjacent == 0 else block_x + tile_width
	var y:int = block_y * tile_height
	
	var ret:Rect2 = Rect2(x, y, tile_width, tile_height)
#	printerr("Tile : %d - Rect : (%s)" % [tile_index, str(ret)])
	return ret

static func get_shadermotion_tile(
	main_texture:Image,
	tile_index:int,
	adjacent:bool,
	tiles_per_column:int = 45,
	tile_width:int = 24,
	tile_height:int = 24
) -> Texture2D:
	var region : Rect2 = shadermotion_tile_rect(
		tile_index, int(adjacent),
		tiles_per_column, tile_width, tile_height)
	var ret_texture = ImageTexture.new()
	var image = main_texture.get_region(region)
	image.resize(1, 1, Image.INTERPOLATE_LANCZOS)
	ret_texture.set_image(image)
	return ret_texture

static func get_shader_motion_tiles_from_texture(
	from_texture:Image,
	frames : SpriteFrames,
	time : float,
	tiles_per_column:int = 45,
	tile_width:int = 24,
	tile_height:int = 24
) -> void:
	var frame_name = String.num(time)
	if frames.has_animation(frame_name):
		return
	frames.add_animation(frame_name)
	var i:int = 0
	for frame_block_name in ShaderMotionHelpers.block_tiles:
		var frame_block:Array = ShaderMotionHelpers.block_tiles[frame_block_name]
		for tile_index in frame_block:
			var tile:Texture2D = get_shadermotion_tile(
				from_texture, tile_index, false,
				tiles_per_column, tile_width, tile_height)
			var tile_adjacent:Texture2D = get_shadermotion_tile(
				from_texture, tile_index, true,
				tiles_per_column, tile_width, tile_height)
			frames.add_frame(frame_name, tile, i)
			frames.add_frame(frame_name, tile_adjacent, i+1)
			i += 2

static func get_shader_motion_tiles_part(
	video_frame:Texture2D,
	tiles_columns:int = 3,
	tiles_per_column:int = 45,
	tile_width:int = 24,
	tile_height:int = 24
) -> Texture2D:
	var ret_texture:Texture2D = AtlasTexture.new()
	ret_texture.atlas = video_frame
	ret_texture.region = Rect2(
		0, 0,
		tile_width * tiles_columns * 2, tile_height * tiles_per_column)
	return ret_texture

# This one rounds to even. Meaning that
# 10.5f rounds to 10
# 11.5f founds to 12
static func _unity_roundi(value:float) -> int:
	var rounded:int = roundi(value)
	if abs(value - rounded) != 0.5:
		return rounded
	else:
		return snappedi(value, 2)

# ???
# Basically a copy-paste adaptation of ShaderMotion
# ShaderImpl.DecodeVideoFloat
static func decode_video_float(
	high:float,
	low:float,
	power:int
) -> float:

	var half_pow = (power - 1) / 2
	high = high * half_pow + half_pow
	low  = low  * half_pow + half_pow

	var x = _unity_roundi(low)

	var low_remainder = low - x
	var y = min(low_remainder, 0)
	var z = max(low_remainder, 0)
	var rounded_high = _unity_roundi(high)

	if (rounded_high & 1) != 0:
		x = power - 1 - x
		var minus_z = -z
		var minus_y = -z
		y = minus_z
		z = minus_y

	if x == 0:
		y += min(0, high - rounded_high)
	if x == power - 1:
		z += max(0, high - rounded_high)

	x += rounded_high * power;
	x -= (power*power-1)/2;

	y += 0.5;
	z -= 0.5;

	var max_y_z = max(abs(y), abs(z))

	return (
		(y + z)
		/ max_y_z
		* 0.5
		+ x
	) / half_pow;

# ???
# A copy-paste implementation of ShaderImpl.orthogonalize
# Returns 2 vectors
static func orthogonalize(u:Vector3, v:Vector3) -> PackedVector3Array:
	var b:float = u.dot(v) * -2
	var a:float = u.dot(u) + v.dot(v)

	a += sqrt(abs(a * a - b * b))

	var ret_u:Vector3 = a * u + b * v
	ret_u *= (u.dot(ret_u) / ret_u.dot(ret_u))
	var ret_v:Vector3 = a * v + b * u
	ret_v *= (v.dot(ret_v) / ret_v.dot(ret_v))

	var returned_vectors:PackedVector3Array = PackedVector3Array()
	returned_vectors.append(ret_u)
	returned_vectors.append(ret_v)

	return returned_vectors

class HipsData:
	var position:Vector3 = NodeHelpers.invalid_vector
	var rotation:Quaternion = NodeHelpers.invalid_quaternion
	var scale:float = NAN

	func set_transform(
		new_position:Vector3,
		new_rotation:Quaternion,
		new_scale:float
	):
		self.position = new_position
		self.rotation = new_rotation
		self.scale = new_scale

	func meow():
		return (
			"Position : %s\nRotation : %s\nScale : %s"
			% [str(position), str(rotation), str(scale)]
		)

class MotionData:
	var swing_twist:Vector3 = NodeHelpers.invalid_vector
	var computed_rotation:Quaternion = NodeHelpers.invalid_quaternion
	var setup:bool = false

	func set_motion_data(swing_twist_data:Vector3, rotation_data:Quaternion):
		self.swing_twist = swing_twist_data
		self.computed_rotation = rotation_data
		self.setup = true

class ParsedMotions:
	var hips:HipsData = HipsData.new()
	var swing_twists:Array[MotionData]

	func _init():
		var swing_twists_values:Array[MotionData] = Array()
		swing_twists_values.resize(ShaderMotionHelpers.MecanimBodyBone.LastBone)

		for bone in range(int(ShaderMotionHelpers.MecanimBodyBone.LastBone)):
			swing_twists_values[bone] = MotionData.new()

		self.swing_twists = swing_twists_values

	func _add_vector3_field(strings:PackedStringArray, vector:Vector3):
		strings.append(str(vector.x))
		strings.append(str(vector.y))
		strings.append(str(vector.z))

	func _add_quaternion_field(strings:PackedStringArray, quaternion:Quaternion):
		strings.append(str(quaternion.x))
		strings.append(str(quaternion.y))
		strings.append(str(quaternion.z))
		strings.append(str(quaternion.w))

	func _generate_record_from(fields:PackedStringArray) -> String:
		return "\t".join(fields)

	func export_to_tsv(tsv_filepath:String):
		var records:PackedStringArray = PackedStringArray()
		var header:PackedStringArray = PackedStringArray(
			[
				"Bone name",
				"SwingTwist.x",
				"SwingTwist.y",
				"SwingTwist.z",
				"Rotation.x",
				"Rotation.y",
				"Rotation.z",
				"Rotation.w",
				"Scale"
			]
		)
		var bone_names = ShaderMotionHelpers.MecanimBodyBone.keys()


		records.append(_generate_record_from(header))

		var current_record:PackedStringArray = PackedStringArray()
		for bone in range(int(ShaderMotionHelpers.MecanimBodyBone.LastBone)):

			current_record.clear()
			current_record.append(bone_names[bone])

			if bone != ShaderMotionHelpers.MecanimBodyBone.Hips:
				var bone_record:MotionData = swing_twists[bone]
				_add_vector3_field(current_record, bone_record.swing_twist)
				_add_quaternion_field(current_record, bone_record.computed_rotation)
				current_record.append(str(NAN))
			else:
				_add_vector3_field(current_record, hips.position)
				_add_quaternion_field(current_record, hips.rotation)
				current_record.append(str(hips.scale))
			records.append(_generate_record_from(current_record))

		var tsv_content:String = "\n".join(records)
		var tsv_file = FileAccess.open(tsv_filepath, FileAccess.WRITE)
		tsv_file.store_string(tsv_content)

static func _shadermotion_apply_scale(
	skeleton_root:Node3D,
	hips_data:HipsData,
	skeleton_human_scale:float,
	human_scale:float
) -> void:

	if human_scale == 0:
		return

	var base_scale:float = human_scale if human_scale > 0 else hips_data.scale 
	skeleton_root.scale = base_scale / skeleton_human_scale * Vector3.ONE
	return

static func _shadermotion_compute_hips_position(
	skeleton_root:Node3D,
	hips_data:HipsData,
	skeleton_human_scale:float
) -> Vector3:

	var applied_scale:float = hips_data.scale / skeleton_human_scale
	var local_point:Vector3 = hips_data.position / applied_scale
	return skeleton_root.to_global(local_point)

static func _shadermotion_compute_bone_rotation(
	bone_data:Dictionary,
	motion_rotation:Quaternion
) -> Quaternion:

	var pre_rotation:Quaternion = bone_data["pre_rotation"] as Quaternion
	var post_rotation:Quaternion = bone_data["post_rotation"] as Quaternion

	return pre_rotation * motion_rotation * (post_rotation.inverse())

static func _shadermotion_multiply_bone_rotation(
	bone_data:Dictionary,
	motion_rotation:Quaternion,
	current_rotation:Quaternion
) -> Quaternion:

	var post_rotation:Quaternion = bone_data["post_rotation"] as Quaternion

	return current_rotation * post_rotation * motion_rotation * (post_rotation.inverse())

static func _shadermotion_apply_human_pose(
	skeleton_bones:Array[Node3D],
	skeleton_human_scale:float,
	parsed_motions:ParsedMotions
):

	var skeleton_root:Node3D = Node3D.new()

	_shadermotion_apply_scale(
		skeleton_root,
		parsed_motions.hips,
		skeleton_human_scale,
		-1)

	printerr("Skeleton root scale : %s" % [str(skeleton_root.scale)])

	var hips_position:Vector3 = _shadermotion_compute_hips_position(
		skeleton_root,
		parsed_motions.hips,
		skeleton_human_scale)

	printerr(hips_position)
	skeleton_bones[MecanimBodyBone.Hips].position = hips_position

	for bone in range(0, int(MecanimBodyBone.LastBone)):

		var decoded_rotation:Quaternion = parsed_motions.swing_twists[bone].computed_rotation
		if decoded_rotation == NodeHelpers.invalid_quaternion:
			continue

		var bone_rotation:Quaternion
		if bone != MecanimBodyBone.UpperChest:
			bone_rotation = _shadermotion_compute_bone_rotation(
				human_axes[bone],
				decoded_rotation)
		else:
			bone_rotation = _shadermotion_multiply_bone_rotation(
				human_axes[bone],
				decoded_rotation,
				skeleton_bones[bone].quaternion)
		skeleton_bones[bone].quaternion = bone_rotation

