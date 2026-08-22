event_inherited()

if (place_meeting(x, y, target)) {
	if (frictionless) {
		target.xVelocityFrictionless = x_vel
		target.alarm[playerAlarms.removeFrictionlessXVelocity] = frictionlessTimeout
	}
	target.xVelocity = x_vel
	target.grav = y_vel
}