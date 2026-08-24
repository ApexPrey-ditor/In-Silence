event_inherited()

var _targets = ds_list_create()
instance_place_list(x, y, target, _targets, false)

for (var i = 0; i < ds_list_size(_targets); i++) {
	var _targeted = ds_list_find_value(_targets, i)
	if (frictionless and _targeted.object_index == obj_player) {
		_targeted.xVelocityFrictionless = x_vel
		_targeted.alarm[playerAlarms.removeFrictionlessXVelocity] = frictionlessTimeout
	}
	if (x_vel != 0) {
		_targeted.xVelocity = x_vel
	}
	if (y_vel != 0) {
		_targeted.grav = y_vel
		
		if (_targeted.object_index == obj_player) {
			_targeted.canMove = true
			_targeted.canWalk = true
		}
	}
}