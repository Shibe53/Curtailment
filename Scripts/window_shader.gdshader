shader_type canvas_item;

uniform vec2 mask_position;  // Center of the mask in UV space
uniform vec2 mask_size;      // Width and height of the mask in UV space
uniform float edge_smoothness = 1.0;  // Smoothing effect

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV); // Get sprite texture

    // Compute half extents
    vec2 half_size = mask_size * 0.5;

    // Compute distance from the mask center
    vec2 dist = abs(UV - mask_position) - half_size;

    // If inside the box, visibility is 1. Otherwise, smoothly fade out.
    float visibility = 1.0 - smoothstep(0.0, edge_smoothness, max(dist.x, dist.y));

    // Apply mask effect
    COLOR = tex_color;
    COLOR.a *= visibility;
}
