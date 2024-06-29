shader_type canvas_item;

void vertex() {
	VERTEX.y += sin(VERTEX.y + TIME) * 20.0;
}



//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
