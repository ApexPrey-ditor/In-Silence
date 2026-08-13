#macro baseWidth 1920
#macro baseHeight 1080

viewWidth = 1920
viewHeight = 1080

cameraX = 0
cameraY = 0

scale = 1
targetScale = 1
scaleSpeed = 0

function scr_camera_apply_borders() {
	if (viewHeight < room_height and viewWidth < room_width) {
		// Set camera borders so it doesnt go offscreen
		cameraX = x - viewWidth / 2
		cameraY = y - viewHeight / 2
	
		cameraX = max(0, min(cameraX, room_width - viewWidth))
		cameraY = max(0, min(cameraY, room_height - viewHeight))
	}
	else {
		cameraX = (room_width / 2) - (viewWidth / 2)
		cameraY = (room_height / 2) - (viewHeight / 2)
	}
}

function scr_camera_scale(targetPos, time) {
	scaleSpeed = (targetPos - scale) / time
	targetScale = targetPos
}

scr_camera_apply_borders()
camera = camera_create_view(cameraX, cameraY, viewWidth, viewHeight)
view_camera[0] = camera
view_visible[0] = true
view_enabled = true