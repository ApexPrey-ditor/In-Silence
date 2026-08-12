// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_apply_x_velocity(xvel, solids, diving=false, sliding=false, nonPassable=noone, xvelFrictionless=0, moving=true) {
	if (nonPassable == noone) {
		nonPassable = solids
	}
	
	var returnedXvel = xvel
	
	if (place_meeting(x, y + 1, solids) and !sliding) {
		returnedXvel = returnedXvel * groundResistance
	}
	else if (!diving and !moving) {
		returnedXvel = returnedXvel * airResistance
	}
	
	xvel += xvelFrictionless
	
	x += xvel
	
	if (place_meeting(x + sign(xvel), y, nonPassable)) {
		x = floor(x)
		
		while (place_meeting(x, y, nonPassable)) {
			x -= scr_plus_minus(xvel)
		}
		
		return 0
	}
	
	return returnedXvel
}