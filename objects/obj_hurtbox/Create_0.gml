xOffset = 0
yOffset = 0

attached = noone

if (attach) {
	attached = instance_place(x, y, obj_moving_hitbox)
	
	if (attached != noone) {
		xOffset = attached.x - x
		yOffset = attached.y - y
	}
}