grav = scr_apply_gravity(grav, baseIntensity, terminalVelocity, solids)
xVelocity = scr_apply_x_velocity(xVelocity, topXSpeed, solids)

if (hitpoints <= 0) {
	instance_destroy()
}

if (place_meeting(x, y, obj_hurtbox)) {
	instance_destroy()
}

if (doBasicWalk) {
	xVelocity = topXSpeed * xDirection

	if (place_meeting(x + xDirection, y, solids) or !position_meeting(x + (abs(sprite_width) / 2 * xDirection) + xDirection, bbox_bottom + stepUpHeight + 1, solids) or bbox_left + xVelocity < 0 or bbox_right + xVelocity > scr_get_room_size()[coordinate.xPosition]) {
		xDirection = -xDirection
		image_xscale = -image_xscale
		xVelocity = 0
	}
}