// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_shove_out(solids, nonpassable=noone){
	if (nonpassable == noone) {
		nonpassable = solids
	}
	
	var testX = x
	var testY = y
	
	var origX = x
	var origY = y
	
	var highscore = infinity
	var currentScore = 0
	
	var movementAmountX = 0
	var movementAmountY = 0
	
	if (place_meeting(x, y, solids)) {
		show_debug_message("----------------------------------")
		
		// Push out right
		while (place_meeting(testX, origY, solids)) {
			//show_debug_message("Right " + string(currentScore))
			currentScore += 1
			testX += 1
		}
		
		highscore = currentScore
		x = origX + currentScore
		movementAmountX = currentScore
		
		testX = origX
		currentScore = 0
		
		
		// Push out left
		while (place_meeting(testX, origY, solids) and currentScore < highscore) {
			//show_debug_message("Left " + string(currentScore))
			currentScore += 1
			testX -= 1
		}
		
		if (currentScore < highscore) {
			highscore = currentScore
			x = origX - currentScore
			movementAmountX = -currentScore
		}
		
		testX = origX
		currentScore = 0
		
		// Push out up
		while (place_meeting(origX, testY, solids) and currentScore < highscore) {
			//show_debug_message("Up " + string(currentScore))
			currentScore += 1
			testY -= 1
		}
		
		if (currentScore < highscore) {
			highscore = currentScore
			y = origY - currentScore
			x = origX
			movementAmountY = -currentScore
			movementAmountX = 0
		}
		
		testY = origY
		currentScore = 0
		
		// Push out down
		while (place_meeting(origX, testY, nonpassable) and currentScore < highscore) {
			//show_debug_message("Down " + string(currentScore))
			currentScore += 1
			testY += 1
		}
		
		if (currentScore < highscore) {
			highscore = currentScore
			y = origY + currentScore
			x = origX
			movementAmountY = currentScore
			movementAmountX = 0
		}
	}
	
	return [movementAmountX, movementAmountY]
	
	
	/*
	if (nonpassable == noone) {
		nonpassable = solids
	}
	
	var prebboxLeft = bbox_left + 1
	var prebboxRight = bbox_right - 1
	var prebboxTop = bbox_top + 1
	var prebboxBottom = bbox_bottom - 1
	
	var origX = x
	var origY = y
	
	var highscore = infinity
	var currentScore = 0
	
	var preXScale = image_xscale
	var preYScale = image_yscale
	
	var movementAmountX = 0
	var movementAmountY = 0
	
	if (place_meeting(x, y, solids)) {
		show_debug_message("----------------------------------")
	}
	
	image_xscale = 1 / sprite_width * scr_plus_minus(preXScale)
	
	if (place_meeting(prebboxLeft, y, solids)) {
		while (place_meeting(prebboxLeft, y, solids)) {
			show_debug_message("Right " + string(currentScore))
			currentScore += 1
			prebboxLeft += 1
			movementAmountX += 1
		}
		
		highscore = currentScore
	}
	currentScore = 0
	if (place_meeting(prebboxRight, y, solids)) {
		while (place_meeting(prebboxRight, y, solids) and currentScore < highscore) {
			show_debug_message("Left " + string(currentScore))
			currentScore += 1
			prebboxRight -= 1
			movementAmountX -= 1
		}
		
		if (currentScore < highscore) {
			highscore = currentScore
			x = origX - currentScore
		}
	}
	
	image_xscale = preXScale
	image_yscale = 1 / sprite_height
	
	currentScore = 0
	if (place_meeting(origX, prebboxBottom, solids)) {
		while (place_meeting(origX, prebboxBottom, solids) and currentScore < highscore) {
			show_debug_message("Up " + string(currentScore))
			currentScore += 1
			prebboxBottom -= 1
			movementAmountY -= 1
		}
		
		if (currentScore < highscore) {
			highscore = currentScore
			y = origY - currentScore
			x = origX
		}
	}
	currentScore = 0
	if (place_meeting(origX, prebboxTop, nonpassable)) {
		while (place_meeting(origX, prebboxTop, nonpassable) and currentScore < highscore) {
			show_debug_message("Down " + string(currentScore))
			currentScore += 1
			prebboxTop += 1
			movementAmountY += 1
		}
		
		if (currentScore < highscore) {
			highscore = currentScore
			y = origY + currentScore
			x = origX
		}
	}
	
	image_yscale = preYScale
	
	return [movementAmountX, movementAmountY]*/
}