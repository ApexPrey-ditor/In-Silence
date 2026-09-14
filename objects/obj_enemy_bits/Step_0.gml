if (place_meeting(x + xVelocity, y, nonpassable)) {
	while (!place_meeting(x + sign(xVelocity), y, solids)) {
		x += sign(xVelocity)
	}
	
	xVelocity = -xVelocity * bounceEfficiency
}

if (place_meeting(x, y + grav, solids) and (grav > 0 or place_meeting(x, y + grav, nonpassable))) {
	while (!place_meeting(x, y + sign(grav), solids)) {
		y += sign(grav)
	}
	
	grav = -grav * bounceEfficiency
}

grav = scr_apply_gravity(grav, baseIntensity, terminalVelocity, solids, nonpassable)
xVelocity = scr_apply_x_velocity(xVelocity, solids, true, nonpassable)

image_angle += xVelocity

if (timeAlive > lifespan) {
	image_alpha -= 1 / fadetime
}

if (image_alpha <= 0) {
	instance_destroy()
}

timeAlive += 1

if (timeAlive % ceil(burstRate / sqrt(power(xVelocity, 2) + power(grav, 2))) == 0) {
	array_push(prevPos, [x, y])
	
	if (array_length(prevPos) > trackLimit) {
		array_delete(prevPos, 0, 1)
	}
}