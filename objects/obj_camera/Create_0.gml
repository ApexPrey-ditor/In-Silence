viewWidth = 1920
viewHieght = 1080

cameraX = 0
cameraY = 0

function scr_camera_apply_borders() {
	if (viewHieght < scr_get_room_size()[roomSize.height] and viewWidth < scr_get_room_size()[roomSize.width]) {
		// Set camera borders so it doesnt go offscreen
		cameraX = x - viewWidth / 2
		cameraY = y - viewHieght / 2
	
		cameraX = max(0, min(cameraX, scr_get_room_size()[roomSize.width] - viewWidth))
		cameraY = max(0, min(cameraY, scr_get_room_size()[roomSize.height] - viewHieght))
	}
	else {
		cameraX = (scr_get_room_size()[roomSize.width] / 2) - (viewWidth / 2)
		cameraY = (scr_get_room_size()[roomSize.height] / 2) - (viewHieght / 2)
	}
}

scr_camera_apply_borders()
camera = camera_create_view(cameraX, cameraY, viewWidth, viewHieght)
view_camera[0] = camera
view_visible[0] = true
view_enabled = true