if (talking) {
	obj_textbox_manager.drawTextbox = false
	
	if (instance_exists(obj_player)) {
		obj_player.canMove = true
	}
}