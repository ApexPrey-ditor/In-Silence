for (var i = 0; i < array_length(prevPos); i++) {
	draw_set_colour($0000FF)
	draw_set_alpha(((i / trackLimit)) * image_alpha)
	
	var squareSize = 5
	
	draw_rectangle(prevPos[i][0] - squareSize, prevPos[i][1] - squareSize, prevPos[i][0] + squareSize, prevPos[i][1] + squareSize, false)
}

scr_reset_draw()

draw_self()