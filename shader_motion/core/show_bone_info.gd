extends Node

@export var ui_name: Label
@export var ui_position: Label
@export var ui_rotation: Label


func _ready():
	NodeHelpers.stop_if_any_is_null(self, [ui_name, ui_position, ui_rotation], "Show Bone Info")


func show_bone(bone: Node3D):
	ui_name.text = bone.name
	ui_position.text = str(bone.position)
	if bone.quaternion.is_finite():
		ui_rotation.text = str(bone.quaternion)
	else:
		ui_rotation.text = ""
