viewWidth = 1920
viewHieght = 1080

cameraX = 0
cameraY = 0

enum roomSize {
	width,
	height
}

function scr_camera_apply_borders() {
	// Set camera borders so it doesnt go offscreen
	cameraX = x - viewWidth / 2
	cameraY = y - viewHieght / 2
	
	cameraX = max(0, min(cameraX, scr_get_room_size()[roomSize.width] - viewWidth))
	cameraY = max(0, min(cameraY, scr_get_room_size()[roomSize.height] - viewHieght))
}

scr_camera_apply_borders()
camera = camera_create_view(cameraX, cameraY, viewWidth, viewHieght)
view_camera[0] = camera
view_visible[0] = true
view_enabled = true