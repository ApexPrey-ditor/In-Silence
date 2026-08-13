draw_set_colour(colour)
/*draw_line_width(x + (endX - x) * max(0, currentTime - 1 / fadeTime),
				y + (endY - y) * max(0, currentTime - 1 / fadeTime),
				x + (endX - x) * min(1, currentTime + 1 / fadeTime),
				y + (endY - y) * min(1, currentTime + 1 / fadeTime),
				width * (1 - currentTime))*/

if (type == "line") {
	draw_line_width(x + (endX - x) * max(0, currentTime - 1 / fadeTime),
					y + (endY - y) * max(0, currentTime - 1 / fadeTime),
					endX, endY, width * (1 - currentTime))
}
if (type == "circle") {
	draw_set_alpha(1 - currentTime)
	draw_circle(x, y, width, false)
}

scr_reset_draw()