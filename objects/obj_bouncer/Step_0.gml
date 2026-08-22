event_inherited()

var _targeted = instance_place(x, y, target)

if (_targeted != noone) {
	if (frictionless) {
		_targeted.xVelocityFrictionless = x_vel
		_targeted.alarm[playerAlarms.removeFrictionlessXVelocity] = frictionlessTimeout
	}
	_targeted.xVelocity = x_vel
	_targeted.grav = y_vel
}