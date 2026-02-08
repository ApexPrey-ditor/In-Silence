event_inherited()

xVelocity = topXSpeed * xDirection

if (place_meeting(x + xVelocity, y, obj_solid_hitbox)) {
	xDirection = -xDirection
}