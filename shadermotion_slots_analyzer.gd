extends VBoxContainer

@export var shadermotion_slot_analyzer:PackedScene
@export var show_in:Control

func remove_children_in(control:Control):
	var last_child = control.get_child(-1)
	while last_child != null:
		remove_child(last_child)
		last_child = control.get_child(-1)

func show_slots_from(pixels:SpriteFrames):
	remove_children_in(show_in)
	for i in range(0, 129):
		var slot = shadermotion_slot_analyzer.instantiate()
		add_child(slot)
		slot.show_slot(pixels, i)

func _ready():
	if shadermotion_slot_analyzer == null or show_in == null:
		printerr("[%s] [ShaderMotion Slots Analyzer] Script badly setup !" % name)
		process_mode = Node.PROCESS_MODE_DISABLED
		return
