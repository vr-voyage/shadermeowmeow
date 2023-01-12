extends VBoxContainer

@export var shader_motion_block_analyzer_prefab:PackedScene
@export var show_in:Control

# Godot bug
# Doing ShaderMotionHelpers.FrameBlock.keys()
# will break Godot 4.x
# So I have to copy it here at the moment
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
	PRIVATE_USE,
	COUNT
}

func _block_encodes_swing_twist(block_name:ShaderMotionHelpers.FrameBlock) -> bool:
	return (block_name >= FrameBlock.SPINE)

func show_all_blocks(pixels:SpriteFrames):
	var block_names = FrameBlock.keys()
	var current_block_name:String
	var current_block_tiles:Array
	# Skipping PRIVATE_USE
	for block in range(0, len(block_names)-1):
		current_block_tiles = ShaderMotionHelpers.block_tiles[block]
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
