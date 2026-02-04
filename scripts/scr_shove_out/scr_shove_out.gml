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
	
	var movementAmountX = 0
	var movementAmountY = 0
	
	mask_index = spr_jimBob_hitbox_horizontal
	
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
	
	mask_index = spr_jimBob_hitbox_vertical
	
	if (position_meeting(x, prebboxBottom, solids)) {
		show_debug_message("screw ts")
		while (place_meeting(x, prebboxBottom, solids)) {
			y -= 1
			prebboxBottom -= 1
			movementAmountY -= 1
		}
	}
	if (place_meeting(x, prebboxTop, nonpassable)) {
		while (place_meeting(x, prebboxTop, nonpassable)) {
			y += 1
			prebboxTop += 1
			movementAmountY += 1
		}
	}
	
	mask_index = sprite_index
	
	return [movementAmountX, movementAmountY]
}