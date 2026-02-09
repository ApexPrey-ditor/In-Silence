grav = scr_apply_gravity(grav, baseIntensity, terminalVelocity, solids)
xVelocity = scr_apply_x_velocity(xVelocity, topXSpeed, solids)

if (hitpoints <= 0) {
	instance_destroy()
}

if (place_meeting(x, y, obj_hurtbox)) {
	instance_destroy()
}