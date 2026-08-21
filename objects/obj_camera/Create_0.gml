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
	// Set camera borders so it doesnt go offscreen
	cameraX = x - viewWidth / 2
	cameraY = y - viewHeight / 2
	
	cameraX = max(0, min(cameraX, room_width - viewWidth))
	cameraY = max(0, min(cameraY, room_height - viewHeight))
}

function scr_camera_scale(targetPos, time) {
	if (targetPos == 0) {
		// 0 is actually a key for set to room size (wow so cool)
		targetPos = min(room_width / baseWidth, room_height / baseHeight)
	}
	if (time == 0) {
		show_debug_message("Invalid Camera Time Scale")
	}
	else {
		scaleSpeed = (targetPos - scale) / time
		
		targetScale = targetPos
	}
}

scr_camera_apply_borders()
camera = camera_create_view(cameraX, cameraY, viewWidth, viewHeight)
view_camera[0] = camera
view_visible[0] = true
view_enabled = true