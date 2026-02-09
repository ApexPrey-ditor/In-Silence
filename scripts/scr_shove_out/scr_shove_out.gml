// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_shove_out(solids, nonpassable=noone){
	if (nonpassable == noone) {
		nonpassable = solids
	}
	
	var prebboxLeft = bbox_left + 1
	var prebboxRight = bbox_right - 1
	var prebboxTop = bbox_top + 1
	var prebboxBottom = bbox_bottom - 1
	
	var preXScale = image_xscale
	var preYScale = image_yscale
	
	var movementAmountX = 0
	var movementAmountY = 0
	
	
	image_xscale = 1 / sprite_width
	image_yscale = (sprite_height - 2) / sprite_height
	
	if (place_meeting(prebboxLeft, y, solids)) {
		while (place_meeting(prebboxLeft, y, solids)) {
			x += 1
			prebboxLeft += 1
			movementAmountX += 1
		}
	}
	if (place_meeting(prebboxRight, y, solids)) {
		while (place_meeting(prebboxRight, y, solids)) {
			x -= 1
			prebboxRight -= 1
			movementAmountX -= 1
		}
	}
	
	image_xscale = (sprite_width - 2) / sprite_width
	image_yscale = 1 / sprite_height
	
	if (place_meeting(x + 1, prebboxBottom, solids)) {
		while (place_meeting(x, prebboxBottom, solids)) {
			y -= 1
			prebboxBottom -= 1
			movementAmountY -= 1
		}
	}
	if (place_meeting(x + 1, prebboxTop, nonpassable)) {
		while (place_meeting(x, prebboxTop, nonpassable)) {
			y += 1
			prebboxTop += 1
			movementAmountY += 1
		}
	}
	
	image_yscale = preYScale
	image_xscale = preXScale
	
	return [movementAmountX, movementAmountY]
}