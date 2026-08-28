// Inherit the parent event
event_inherited()

grav = scr_apply_gravity(grav, baseIntensity, terminalVelocity, solids, nonpassable)
xVelocity = scr_apply_x_velocity(xVelocity, solids, false, nonpassable)

// actual AI
if (not doBasicWalk and instance_exists(obj_player)) {
	image_xscale = scr_plus_minus(obj_player.x - x) * abs(image_xscale)
	
	if (distance_to_object(obj_player) > range or collision_line(x, y, obj_player.x, obj_player.y, lineOfSightBlockers, false, true) != noone) {
		image_speed = 1
		
		alarm[0] = -1
		charging = false
		
		if (place_meeting(x, y + 1, solids)) {
			xVelocity += sign(image_xscale) * xAcceleration
			xVelocity = clamp(xVelocity, -topXSpeed, topXSpeed)

			if (place_meeting(x + xVelocity * solidJumpRange, y, solids) and collision_line(x, y, x + xVelocity * solidJumpRange, y, obj_player, false, true) == noone) {
				grav = -jumpHeight
			}
		}
		else {
			if (abs(xVelocity) < topXSpeed) {
				xVelocity += sign(image_xscale) * xAcceleration / airControlFactor
			}
		}
	}
	else {
		xVelocity = 0
		
		if (not charging) {
			charging = true
			
			// shooting cooldown
			alarm[0] = cooldown
		}
	}
}