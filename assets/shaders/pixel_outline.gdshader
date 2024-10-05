shader_type canvas_item;

// TODO: fix outline beyond sprite and increase directions.

uniform float outline_width: hint_range(0.0, 5.0, 1.0) = 1.0;
uniform vec4 outline_color: source_color = vec4(1.0);

const vec2 DIRS[4] = {
	vec2(1.0, 0.0),
	vec2(-1.0, 0.0),
	vec2(0.0, 1.0),
	vec2(0.0, -1.0)
};

void fragment() {
	vec2 shift_distance = outline_width * TEXTURE_PIXEL_SIZE;
	float alpha = 0.0;

	for (int i = 0; i < DIRS.length(); i++) {
		vec2 uv = UV - shift_distance * DIRS[i];
		alpha += texture(TEXTURE, uv).a;
	}

	if (texture(TEXTURE, UV).a == 0.0)
		COLOR = outline_color;

	COLOR.a = alpha;
}