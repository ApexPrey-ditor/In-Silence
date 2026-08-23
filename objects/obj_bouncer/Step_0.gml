event_inherited()

var _targets = ds_list_create()
instance_place_list(x, y, target, _targets, false)

for (var i = 0; i < ds_list_size(_targets); i++) {
	var _targeted = ds_list_find_value(_targets, i)
	if (frictionless and _targeted.object_index == obj_player) {
		_targeted.xVelocityFrictionless = x_vel
		_targeted.alarm[playerAlarms.removeFrictionlessXVelocity] = frictionlessTimeout
	}
	_targeted.xVelocity = x_vel
	_targeted.grav = y_vel
}