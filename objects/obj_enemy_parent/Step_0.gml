activated = true

if (hitpoints <= 0) {
	global.comboKills += 1
	instance_destroy()
}

if (place_meeting(x, y, obj_hurtbox)) {
	instance_destroy()
}

var _collidingEnemy = instance_place(x, y, obj_enemy_parent)

if (_collidingEnemy != noone) {
	var _centerDistance = point_distance(x, y, _collidingEnemy.x, _collidingEnemy.y)
	if (_centerDistance < friendlyPushback) {
		_collidingEnemy.xVelocity += (friendlyPushback - _centerDistance)
	}
}


if (instance_exists(obj_player)) {
	if (distance_to_object(obj_player) < visualDetectionRange and collision_line(x, y, obj_player.x, obj_player.y, solids, false, true) == noone) {
		event_user(enemyUserEvents.globalDetect)
	}
}

if (doBasicWalk and place_meeting(x, y + 1, solids)) {
	xVelocity = walkSpeed * xDirection

	if (place_meeting(x + xDirection, y, solids) or !position_meeting(x + (abs(sprite_width) / 2 * xDirection) + xDirection, bbox_bottom + stepUpHeight + 1, solids) or bbox_left + xVelocity < 0 or bbox_right + xVelocity > room_width) {
		xDirection = -xDirection
		image_xscale = -image_xscale
		xVelocity = 0
	}
}