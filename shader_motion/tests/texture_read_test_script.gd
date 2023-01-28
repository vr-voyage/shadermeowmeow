extends Control

@export var color_rect: ColorRect
@export var color_label: Label

var sampling: bool = false


func _ready():
	for bone_name in ShaderMotionHelpers.MecanimBodyBone:
		print("MecanimBodyBone." + bone_name + ": ")

	process_mode = Node.PROCESS_MODE_DISABLED
	return
	if color_rect == null or color_label == null:
		printerr("TextureReadTestUI is not setup correctly")
		process_mode = Node.PROCESS_MODE_DISABLED
		return


func sample_at(pos: Vector2) -> void:
	color_rect.color = get_viewport().get_texture().get_image().get_pixelv(pos)
	var current_color: Color = color_rect.color
	color_label.text = (
		"R : %d - G : %d - B : %d - A : %d" % [current_color.r8, current_color.g8, current_color.b8, current_color.a8]
	)


func _input(event):
	var sampling_position: Vector2 = Vector2.ZERO
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		sampling = mouse_event.pressed
		sampling_position = mouse_event.position

	if event is InputEventMouseMotion and sampling:
		var mouse_event = event as InputEventMouseMotion
		sampling_position = mouse_event.position

	if sampling:
		sample_at(sampling_position)


func _process(delta):
	pass
