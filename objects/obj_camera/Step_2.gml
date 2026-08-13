if (scale != targetScale) {
	scale += scaleSpeed
	
	if (abs((scale - targetScale)) / 2 <= abs(scaleSpeed)) {
		scale = targetScale
	}
	
	viewWidth = ceil(baseWidth * scale)
	viewHeight = ceil(baseHeight * scale)
	
	camera_set_view_size(camera, viewWidth, viewHeight)
}

if (instance_exists(obj_player)) {
	x = obj_player.x
	y = obj_player.y
}

scr_camera_apply_borders()
camera_set_view_pos(camera, cameraX, cameraY)