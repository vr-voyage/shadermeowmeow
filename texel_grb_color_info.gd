extends VBoxContainer

class_name ShowTexelGRB

@export var color_rect:ColorRect
@export var spinbox_r:SpinBox
@export var spinbox_g:SpinBox
@export var spinbox_b:SpinBox

var spinboxes:Array[SpinBox]

func _draw_color(provided_color:Color):
	color_rect.color = provided_color

func _show_color_info(info:Vector3):
	for i in range(0, len(spinboxes)):
		spinboxes[i].value = info[i]

func _color8_to_vector3(color:Color) -> Vector3:
	return Vector3(color.r8, color.g8, color.b8)

func show_color(provided_color:Color):
	_draw_color(provided_color)
	_show_color_info(_color8_to_vector3(provided_color))

func _compute_gray_code(color:Color) -> Vector3:
	var color_values = Vector3(color.r, color.g, color.b)
	return round(color_values * 2)

func show_shadermotion_color(provided_color:Color):
	_draw_color(provided_color)
	_show_color_info(_compute_gray_code(provided_color))

func get_bgr_gray_code() -> Vector3:
	var code = _compute_gray_code(color_rect.color)
	return Vector3(code.y, code.x, code.z)

# Called when the node enters the scene tree for the first time.
func _ready():
	if color_rect == null or spinbox_r == null or spinbox_g == null or spinbox_b == null:
		printerr("[%s] [TexelGRBColorInfo] Script not setup correctly !" % name)
		printerr("[%s] [TexelGRBColorInfo] Disabling..." % name)
		process_mode = Node.PROCESS_MODE_DISABLED
		return
	spinboxes = [spinbox_g, spinbox_r, spinbox_b]

