viewWidth = 1920
viewHieght = 1080

cameraX = 0
cameraY = 0

function scr_camera_apply_borders() {
	if (viewHieght < room_height and viewWidth < room_width) {
		// Set camera borders so it doesnt go offscreen
		cameraX = x - viewWidth / 2
		cameraY = y - viewHieght / 2
	
		cameraX = max(0, min(cameraX, room_width - viewWidth))
		cameraY = max(0, min(cameraY, room_height - viewHieght))
	}
	else {
		cameraX = (room_width / 2) - (viewWidth / 2)
		cameraY = (room_height / 2) - (viewHieght / 2)
	}
}

scr_camera_apply_borders()
camera = camera_create_view(cameraX, cameraY, viewWidth, viewHieght)
view_camera[0] = camera
view_visible[0] = true
view_enabled = true