extends Node

class_name UnityHelpers

const vector_up: Vector3 = Vector3(0, 1, 0)
const vector_forward: Vector3 = Vector3(0, 0, 1)

static func _look_rotation_case_a(
	vector_a: Vector3,
	vector_b: Vector3,
	vector_c: Vector3,
	bx_cy_az: float
) -> Quaternion:
#	var num = (float)Mathf.Sqrt(num8 + 1f);
#	quaternion.w = num * 0.5f;
#	num = 0.5f / num;
#	quaternion.x = (vector_c_z - vector_a_y) * num;
#	quaternion.y = (vector_a_x - vector_b_z) * num;
#	quaternion.z = (vector_b_y - vector_c_x) * num;
#	return quaternion;
	var unknown: float = sqrt(bx_cy_az + 1)
	var xyz_operand: float = 0.5 / unknown
	return Quaternion(
		(vector_c.z - vector_a.y) * xyz_operand,
		(vector_a.x - vector_b.z) * xyz_operand,
		(vector_b.y - vector_c.x) * xyz_operand,
		unknown * 0.5
	)


static func _look_rotation_case_b(
	vector_a: Vector3,
	vector_b: Vector3,
	vector_c: Vector3
) -> Quaternion:
#	var num7 = (float)Mathf.Sqrt(((1f + vector_b_x) - vector_c_y) - vector_a_z);
#	var num4 = 0.5f / num7;
#	quaternion.x = 0.5f * num7;
#	quaternion.y = (vector_b_y + vector_c_x) * num4;
#	quaternion.z = (vector_b_z + vector_a_x) * num4;
#	quaternion.w = (vector_c_z - vector_a_y) * num4;
	var x_operand = sqrt(1 + vector_b.x - vector_c.y - vector_a.z)
	var yzw_operand = 0.5 / x_operand
	return Quaternion(
		0.5 * x_operand,
		(vector_b.y + vector_c.x) * yzw_operand,
		(vector_b.z + vector_a.x) * yzw_operand,
		(vector_c.z - vector_a.y) * yzw_operand
	)


static func _look_rotation_case_c(
	vector_a: Vector3,
	vector_b: Vector3,
	vector_c: Vector3
) -> Quaternion:
#	var num6 = (float)Mathf.Sqrt(((1f + vector_c_y) - vector_b_x) - vector_a_z);
#	var num3 = 0.5f / num6;
#	quaternion.x = (vector_c_x + vector_b_y) * num3;
#	quaternion.y = 0.5f * num6;
#	quaternion.z = (vector_a_y + vector_c_z) * num3;
#	quaternion.w = (vector_a_x - vector_b_z) * num3;
	var y_operand = sqrt(1 + vector_c.y - vector_b.x - vector_a.z)
	var xzw_operand = 0.5 / y_operand
	return Quaternion(
		(vector_c.z + vector_b.y) * xzw_operand,
		0.5 * y_operand,
		(vector_a.y + vector_c.z) * xzw_operand,
		(vector_a.x - vector_b.z) * xzw_operand
	)


static func _look_rotation_case_d(
	vector_a: Vector3,
	vector_b: Vector3,
	vector_c: Vector3
) -> Quaternion:
#	var num5 = (float)Mathf.Sqrt(((1f + vector_a_z) - vector_b_x) - vector_c_y);
#	var num2 = 0.5f / num5;
#	quaternion.x = (vector_a_x + vector_b_z) * num2;
#	quaternion.y = (vector_a_y + vector_c_z) * num2;
#	quaternion.z = 0.5f * num5;
#	quaternion.w = (vector_b_y - vector_c_x) * num2;
	var z_operand: float = sqrt(1 + vector_a.z - vector_b.x - vector_c.y)
	var xyw_operand: float = 0.5 / z_operand
	return Quaternion(
		(vector_a.x + vector_b.z) * xyw_operand,
		(vector_a.y + vector_c.z) * xyw_operand,
		0.5 * z_operand,
		(vector_b.y - vector_c.x) * xyw_operand
	)


static func look_rotation(
	forward_vector: Vector3,
	up_vector: Vector3
) -> Quaternion:
	# Going deeper into the incomprehensible copy-pasta
	# This time it's an implementation of Unity Quaternion.LookRotation
	# coming from
	# https://answers.unity.com/questions/467614/what-is-the-source-code-of-quaternionlookrotation.html
	# And since I'm dumb, I figure out way too late that vector_a, b and c form
	# a 3x3 Matrix actually.

	var forward_normalized = forward_vector.normalized()
	var vector_a: Vector3 = forward_normalized.normalized()  # Yes, it does it twice
	var vector_b: Vector3 = up_vector.cross(forward_normalized).normalized()
	#var vector_b:Vector3 = forward_normalized.cross(up_vector).normalized()
	var vector_c: Vector3 = vector_a.cross(vector_b)

	var bx_cy_az: float = vector_b.x + vector_c.y + vector_a.z
	if bx_cy_az > 0:
		return _look_rotation_case_a(vector_a, vector_b, vector_c, bx_cy_az)
	elif (vector_b.x >= vector_c.y) and (vector_b.x >= vector_a.z):
		return _look_rotation_case_b(vector_a, vector_b, vector_c)
	elif vector_c.y > vector_a.z:
		return _look_rotation_case_c(vector_a, vector_b, vector_c)

	return _look_rotation_case_d(vector_a, vector_b, vector_c)

# This one rounds to even. Meaning that
# 10.5f rounds to 10
# 11.5f founds to 12
static func roundi(value:float) -> int:
	var rounded:int = roundi(value)
	if abs(value - rounded) != 0.5:
		return rounded
	else:
		return snappedi(value, 2)
