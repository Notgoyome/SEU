shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
    COLOR = texture(TEXTURE, UV);
    COLOR.a = 0.2; // Remplace 0.2 par l'opacité que tu veux
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
