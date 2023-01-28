shader_type canvas_item;

vec3 GammaToLinear(vec3 value)
{
	return 
		 value <= vec3(0.04045F)
		 ? value / 12.92F
		 : pow((value + 0.055F)/1.055F, vec3(2.4F));
}

void fragment() {
	// Place fragment code here.
	COLOR = vec4(0.3,0.7,0,1);
	
}
