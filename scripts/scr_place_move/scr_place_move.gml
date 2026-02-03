// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_place_move(xMagnitude, yMagnitude, solids) {
	x += xMagnitude
	
	if (place_meeting(x, y, solids) and xMagnitude != 0) {
		while (place_meeting(x, y, solids)) {
			x -= sign(xMagnitude)
		}
	}
	
	y += yMagnitude
	
	if (place_meeting(x, y, solids) and yMagnitude != 0) {
		while (place_meeting(x, y, solids)) {
			y -= sign(yMagnitude)
		}
	}
}