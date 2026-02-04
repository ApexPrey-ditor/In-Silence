// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_apply_x_velocity(xvel, velocityCap, solids, diving=false) {
	if (abs(xvel) > velocityCap) {
		xvel = velocityCap * sign(xvel)
	}
	if (!place_meeting(x, y + 1, solids) and not diving) {
		xvel = xvel * airResistance
	}
	
	x += xvel
	
	if (place_meeting(x + sign(xvel), y, solids)) {
		x = floor(x)
		
		while (place_meeting(x, y, solids)) {
			x -= sign(xvel)
		}
		
		return 0
	}
	
	return xvel
}