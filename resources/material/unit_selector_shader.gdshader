shader_type canvas_item;

uniform vec4 team_color : source_color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 color = COLOR;
	
	if (color.a > 0.0) {
		COLOR = team_color;
	}
	

}