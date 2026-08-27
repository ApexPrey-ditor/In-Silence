// Inherit the parent event
event_inherited()

grav = scr_apply_gravity(grav, baseIntensity, terminalVelocity, solids, nonpassable)
xVelocity = scr_apply_x_velocity(xVelocity, solids, false, nonpassable)

// actual AI
if (not doBasicWalk and instance_exists(obj_player)) {
	image_xscale = scr_plus_minus(obj_player.x - x) * abs(image_xscale)
	image_speed = abs(xVelocity) / 5
	
	if (distance_to_object(obj_player) < spriteRange) {
		sprite_index = spr_prison_walker_open
	}
	else {
		sprite_index = spr_prison_walker
	}
	
	if (place_meeting(x, y, obj_player)) {
		obj_player.scr_hit()
	}
	
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
		if (abs(xVelocity) < topXSpeed) {
			xVelocity += sign(image_xscale) * xAcceleration / airControlFactor
		}
	}
}