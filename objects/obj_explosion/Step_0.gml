if (frames % ceil(duration / (sprite_get_number(sprite_index) - 1)) == 0) {
	image_index += 1
}

frames += 1