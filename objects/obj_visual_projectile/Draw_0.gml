draw_set_colour(colour)
/*draw_line_width(x + (endX - x) * max(0, currentTime - 1 / fadeTime),
				y + (endY - y) * max(0, currentTime - 1 / fadeTime),
				x + (endX - x) * min(1, currentTime + 1 / fadeTime),
				y + (endY - y) * min(1, currentTime + 1 / fadeTime),
				width * (1 - currentTime))*/
				
draw_line_width(x + (endX - x) * max(0, currentTime - 1 / fadeTime),
				y + (endY - y) * max(0, currentTime - 1 / fadeTime),
				endX, endY, width * (1 - currentTime))

scr_reset_draw()