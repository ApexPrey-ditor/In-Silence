if (place_meeting(x + xVelocity, y, solids)) {
	while (!place_meeting(x + sign(xVelocity), y, solids)) {
		x += sign(xVelocity)
	}
	
	var _collided = instance_place(x + sign(xVelocity), y, solids)
	if (_collided.object_index == obj_grenade) {
		var _sharedVelocity = abs(_collided.xVelocity) + abs(xVelocity)
		
		xVelocity = _sharedVelocity / 2 * sign(xVelocity)
		_collided.xVelocity = _sharedVelocity / 2 * sign(_collided.xVelocity)
	}
	
	xVelocity = -xVelocity * bounceEfficiency
}

if (place_meeting(x, y + grav, solids)) {
	while (!place_meeting(x, y + sign(grav), solids)) {
		y += sign(grav)
	}
	
	var _collided = instance_place(x, y + sign(grav), solids)
	if (_collided.object_index == obj_grenade) {
		var _sharedVelocity = abs(_collided.grav) + abs(grav)
		
		grav = _sharedVelocity / 2 * sign(grav)
		_collided.grav = _sharedVelocity / 2 * sign(_collided.grav)
	}
	
	grav = -grav * bounceEfficiency
}

if (place_meeting(x, y, shootables)) {
	scr_detonate_grenade()
}

grav = scr_apply_gravity(grav, gravIntensity, gravLimit, solids, , true)
xVelocity = scr_apply_x_velocity(xVelocity, solids, , , , , true)