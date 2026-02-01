// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_apply_gravity(currentGravity, intensity, limit, collider, nonpassable=noone) {
	if (nonpassable == noone) {
		nonpassable = collider
	}
	
	if (currentGravity > limit) {
		currentGravity = limit
	}
	
	y += currentGravity
	
	// dont apply gravity if on the ground
	if (place_meeting(x, y + 1, collider) or place_meeting(x, y - 1, collider)) {
		if (currentGravity >= 0) {
			// if gravity is going down and going into a wall, decrease gravity until 1 pixel above solid
			while (place_meeting(x, y, collider)) {
				y -= 1
			}
		}
		else {
			// if gravity is going up and going into a wall, increase gravity until 1 pixel below solid
			while (place_meeting(x, y - 1, nonpassable)) {
				y += 1
			}
		}
		
		return 0
	}
	
	currentGravity += intensity
	
	return currentGravity
}