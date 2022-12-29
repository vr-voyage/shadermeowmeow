extends HBoxContainer

@export var analyzed_pixels : SpriteFrames
@export var analyzer_node : Control


func _ready():
	if analyzer_node == null or analyzed_pixels == null:
		printerr("[%s] [Test Analyzer] Script badly setup." % name)
		process_mode = Node.PROCESS_MODE_DISABLED
		return
	analyzer_node.show_slots_from(analyzed_pixels)

