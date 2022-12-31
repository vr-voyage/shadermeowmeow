extends VBoxContainer

@export var shader_motion_block_analyzer_prefab:PackedScene
@export var show_in:Control

enum block_name {
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
	JAW,
	LEFT_THUMB,
	LEFT_INDEX,
	LEFT_MIDDLE,
	LEFT_RING,
	LEFT_LITTLE,
	RIGHT_THUMB,
	RIGHT_INDEX,
	RIGHT_MIDDLE,
	RIGHT_RING,
	RIGHT_LITTLE,
	PRIVATE_USE
}

const blocks:Array = [
	[0,1,2],
	[3,4,5],
	[6,7,8],
	[9,10,11],
	[12,13,14],
	[15,16,17],
	[18,19,20],
	[21,22,23],
	[24,25,26],
	[27,28,29],
	[30,31,32],
	[33,34,35],
	[36,37,38],
	[39,40,41],
	[42,43,44],
	[45,46,47],
	[48,49,50],
	[51,52,53],
	[54,55,56],
	[57,58,59],
	[60,61,62],
	[63,64,65],
	[66,67,68],
	[69],
	[70],
	[71,72],
	[73,74],
	[75,76],
	[90,91,92,93],
	[94,95,96,97],
	[98,99,100,101],
	[102,103,104,105],
	[106,107,108,109],
	[110,111,112,113],
	[114,115,116,117],
	[118,119,120,121],
	[122,123,124,125],
	[126,127,128,129],
	[77,78,79,80,81,82,83,84,85,86,87,88,89,130,131,132,133,134]
]

func show_all_blocks(pixels:SpriteFrames):
	var block_names = block_name.keys()
	var current_block_name:String
	var current_block_range:Array
	# Skipping PRIVATE_USE
	for i in range(0, len(block_names)-1):
		current_block_range = blocks[i]
		current_block_name = block_names[i]
		var analyzer_node = shader_motion_block_analyzer_prefab.instantiate()
		add_child(analyzer_node)
		analyzer_node.show_shader_motion_block(pixels, current_block_name, current_block_range)

func _ready():
	if shader_motion_block_analyzer_prefab == null or show_in == null:
		printerr("[%s] [ShaderMotion Slots Analyzer] Script badly setup !" % name)
		process_mode = Node.PROCESS_MODE_DISABLED
		return
