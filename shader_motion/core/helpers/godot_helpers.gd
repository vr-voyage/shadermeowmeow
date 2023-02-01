extends Node

# Not inspired on this one.
# This is just a set of random helpers
class_name GodotHelpers

const invalid_color:Color = Color(NAN, NAN, NAN, NAN)

static func image_sample_center_pixel(image:Image) -> Color:

	var ret_color:Color = invalid_color
	if image == null:
		printerr("[GodotHelpers] [ShaderMotion Slot Analyzer] No image on your texture !")
		return ret_color

	if image.is_compressed():
		var err_code:int = image.decompress()
		if err_code != OK:
			printerr("[GodotHelpers] [image_center_color] Could not decompress image for sampling")
			return ret_color

	ret_color = image.get_pixelv(image.get_size() / 2)
	return ret_color

static func unity_rotation_to_godot(unity_rotation:Quaternion) -> Quaternion:
	return (
		Basis.FLIP_X.inverse()
		* Basis(unity_rotation)
		* Basis.FLIP_X
	).get_rotation_quaternion()
