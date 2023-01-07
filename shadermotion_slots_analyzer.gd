extends VBoxContainer

@export var shader_motion_block_analyzer_prefab:PackedScene
@export var show_in:Control

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

func _block_encodes_swing_twist(block_name:FrameBlock) -> bool:
	return (block_name >= FrameBlock.SPINE)

func show_all_blocks(pixels:SpriteFrames):
	var block_names = FrameBlock.keys()
	var current_block_name:String
	var current_block_tiles:Array
	# Skipping PRIVATE_USE
	for block in range(0, len(block_names)-1):
		current_block_tiles = block_tiles[block]
		current_block_name = block_names[block]
		var analyzer_node = shader_motion_block_analyzer_prefab.instantiate()
		add_child(analyzer_node)
		analyzer_node.show_shader_motion_block(
			pixels,
			current_block_name,
			current_block_tiles,
			_block_encodes_swing_twist(block))

func _ready():
	if shader_motion_block_analyzer_prefab == null or show_in == null:
		printerr("[%s] [ShaderMotion Slots Analyzer] Script badly setup !" % name)
		process_mode = Node.PROCESS_MODE_DISABLED
		return
