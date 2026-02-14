// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_apply_x_velocity(xvel, velocityCap, solids, diving=false, nonPassable=noone) {
	if (nonPassable == noone) {
		nonPassable = solids
	}
	
	if (place_meeting(x, y + 1, solids)) {
		if (abs(xvel) > velocityCap) {
			xvel = velocityCap * sign(xvel)
		}
	}
	else if (!diving) {
		xvel = xvel * airResistance
	}
	
	x += xvel
	
	if (place_meeting(x + sign(xvel), y, nonPassable)) {
		if (!place_meeting(x + sign(xvel), y - stepUpHeight, nonPassable) and place_meeting(x - xvel, y + 1, nonPassable)) {
			while (place_meeting(x + sign(xvel), y, solids)) {
				y -= 1
			}
		}
		else {
			x = floor(x)
		
			while (place_meeting(x, y, nonPassable)) {
				x -= scr_plus_minus(xvel)
			}
		
			return 0
		}
	}
	
	return xvel
}