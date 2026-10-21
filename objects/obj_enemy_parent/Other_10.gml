// send detections to others
doBasicWalk = false

with (obj_enemy_parent) {
	if (doBasicWalk and collision_line(x, y, other.x, other.y, solids, false, true) == noone) {
		event_user(enemyUserEvents.detectPlayer)
	}
}