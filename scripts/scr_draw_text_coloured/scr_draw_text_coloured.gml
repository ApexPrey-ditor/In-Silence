function scr_draw_text_coloured(drawX, drawY, text, xScale, yScale, sep, width){
	var currentX = drawX
	var currenyY = drawY
	
	var splitText = string_split(text, " ")
	
	for (var i = 0; i < array_length(splitText); i++) {
		if (abs(currentX - drawX) + string_width(splitText[i]) * xScale > width) {
			currentX = drawX
			currenyY += sep
		}
		else if (i != 0) {
			splitText[i] = " " + splitText[i]
		}
		for (var w = 1; w <= string_length(splitText[i]); w++) {
			var charOn = string_char_at(splitText[i], w)
			
			if (charOn == "§") {
				w++
			
				charOn = string_char_at(splitText[i], w)
			}
			else {
				draw_text_transformed(currentX, currenyY, charOn, xScale, yScale, 0)
			
				currentX += string_width(charOn) * xScale
			}
		}
	}
}