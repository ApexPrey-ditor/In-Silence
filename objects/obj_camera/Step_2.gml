if (scale != targetScale) {
	scale += scaleSpeed
	
	if (abs((scale - targetScale)) / 2 <= abs(scaleSpeed)) {
		scale = targetScale
	}
	
	viewWidth = floor(baseWidth * scale)
	viewHeight = floor(baseHeight * scale)
	
	camera_set_view_size(camera, viewWidth, viewHeight)
}

if (cameraOffsetX != targetXOffset) {
	cameraOffsetX += xSpeed
	
	if (abs((cameraOffsetX - targetXOffset)) / 2 <= abs(xSpeed)) {
		cameraOffsetX = targetXOffset
	}
}

if (cameraOffsetY != targetYOffset) {
	cameraOffsetY += ySpeed
	
	if (abs((cameraOffsetY - targetYOffset)) / 2 <= abs(ySpeed)) {
		cameraOffsetY = targetYOffset
	}
}

if (instance_exists(obj_player)) {
	x = obj_player.x + cameraOffsetX
	y = obj_player.y + cameraOffsetY
}

scr_camera_apply_borders()
camera_set_view_pos(camera, cameraX, cameraY)