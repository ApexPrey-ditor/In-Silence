draw_self()

for (var i = 0; i < array_length(afterImages); i++) {
	draw_sprite_ext(afterImages[i].sprite, afterImages[i].subimage, afterImages[i].x, afterImages[i].y, afterImages[i].xScale, afterImages[i].yScale, 0, c_white, afterImages[i].alpha)
}