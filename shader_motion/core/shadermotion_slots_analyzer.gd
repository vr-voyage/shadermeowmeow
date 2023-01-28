extends VBoxContainer

@export var shader_motion_block_analyzer_prefab: PackedScene
@export var show_in: Control


func _block_encodes_swing_twist(block_name: ShaderMotionHelpers.FrameBlock) -> bool:
	return block_name >= ShaderMotionHelpers.FrameBlock.SPINE


func show_all_blocks(pixels: SpriteFrames):
	var block_names = ShaderMotionHelpers.FrameBlock.keys()
	var current_block_name: String
	var current_block_tiles: Array
	# Skipping PRIVATE_USE
	for block in range(0, len(block_names) - 1):
		current_block_tiles = ShaderMotionHelpers.block_tiles[block]
		current_block_name = block_names[block]
		var analyzer_node = shader_motion_block_analyzer_prefab.instantiate()
		add_child(analyzer_node)
		analyzer_node.show_shader_motion_block(
			pixels, current_block_name, current_block_tiles, _block_encodes_swing_twist(block)
		)


func _ready():
	if shader_motion_block_analyzer_prefab == null or show_in == null:
		printerr("[%s] [ShaderMotion Slots Analyzer] Script badly setup !" % name)
		process_mode = Node.PROCESS_MODE_DISABLED
		return
