if (place_meeting(x + xVelocity, y, solids)) {
	while (!place_meeting(x + sign(xVelocity), y, solids)) {
		x += sign(xVelocity)
	}
	
	xVelocity = -xVelocity * bounceEfficiency
}

if (place_meeting(x, y + grav, solids)) {
	while (!place_meeting(x, y + sign(grav), solids)) {
		y += sign(grav)
	}
	
	grav = -grav * bounceEfficiency
}

scr_apply_gravity(grav, gravIntensity, gravLimit, solids)
scr_apply_x_velocity(xVelocity, solids, false)