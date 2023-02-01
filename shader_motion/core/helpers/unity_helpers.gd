extends Node

class_name UnityHelpers

# This one rounds to even. Meaning that
# 10.5f rounds to 10
# 11.5f founds to 12
static func roundi(value:float) -> int:
	var rounded:int = roundi(value)
	if abs(value - rounded) != 0.5:
		return rounded
	else:
		return snappedi(value, 2)
