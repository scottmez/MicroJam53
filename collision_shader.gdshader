shader_type canvas_item;

uniform float wave_strength = 6.0;
uniform float wave_speed = 1.2;
uniform float wave_scale = 20.0;

uniform vec4 deep_color : source_color = vec4(0.0, 0.2, 0.4, 1.0);
uniform vec4 shallow_color : source_color = vec4(0.0, 0.5, 0.7, 1.0);

void fragment() {
    vec2 uv = UV;

    // Wave distortion
    float wave =
        sin((uv.x + TIME * wave_speed) * wave_scale) +
        cos((uv.y + TIME * wave_speed * 0.8) * wave_scale);

    uv.y += wave * 0.002 * wave_strength;

    // Vertical gradient (top = shallow, bottom = deep)
    float depth = clamp(uv.y, 0.0, 1.0);
    vec4 water_color = mix(shallow_color, deep_color, depth);

    COLOR = water_color;
}
