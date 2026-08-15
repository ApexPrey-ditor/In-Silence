// send detections to others
doBasicWalk = false

with (obj_enemy_parent) {
	if (doBasicWalk) {
		event_user(enemyUserEvents.detectPlayer)
	}
}