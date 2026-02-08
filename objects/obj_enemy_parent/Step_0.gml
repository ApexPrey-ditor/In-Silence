grav = scr_apply_gravity(grav, baseIntensity, terminalVelocity, solids)
xVelocity = scr_apply_x_velocity(xVelocity, topXSpeed, solids)

if (hitpoints <= 0) {
	instance_destroy()
}