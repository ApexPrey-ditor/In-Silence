enum enemyUserEvents {
	globalDetect,
	detectPlayer,
	parried
}

hitpoints = 1

xDirection = sign(image_xscale)

grav = 0
terminalVelocity = 35

xVelocity = 0
doBasicWalk = true
walkSpeed = 0

parryableAttack = false
friendlyPushback = 5

weight = 1

bounceHeight = 10

soundDetectionRange = 2400
visualDetectionRange = 1600

function scr_test_sound_detection(originX, originY, detectionMultiplier=1) {
	if (point_distance(x, y, originX, originY) < visualDetectionRange * detectionMultiplier) {
		event_user(enemyUserEvents.globalDetect)
	}
}

solids = scr_get_objects_of_tag("solid")