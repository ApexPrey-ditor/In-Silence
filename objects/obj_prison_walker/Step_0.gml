// Inherit the parent event
event_inherited()

grav = scr_apply_gravity(grav, baseIntensity, terminalVelocity, solids)
xVelocity = scr_apply_x_velocity(xVelocity, solids, false)

// actual AI
if (not doBasicWalk and instance_exists(obj_player)) {
	image_xscale = scr_plus_minus(obj_player.x - x) * abs(image_xscale)
	if (place_meeting(x, y + 1, solids)) {
		xVelocity += sign(image_xscale) * xAcceleration
		xVelocity = clamp(xVelocity, -topXSpeed, topXSpeed)
		
		if (obj_player.y < y) {
			var _speculativeJumpHeight = -min((y - obj_player.y) / 5, jumpHeight)
			
			if (distance_to_object(obj_player) / abs(xVelocity) < jumpRange * -_speculativeJumpHeight)
			grav = _speculativeJumpHeight
		}
		if (place_meeting(x + xVelocity * solidJumpRange, y, solids) and collision_line(x, y, x + xVelocity * solidJumpRange, y, obj_player, false, true) == noone) {
			grav = -jumpHeight
		}
	}
	else {
		xVelocity += sign(image_xscale) * xAcceleration / airControlFactor
		xVelocity = clamp(xVelocity, -topXSpeed, topXSpeed)
	}
}