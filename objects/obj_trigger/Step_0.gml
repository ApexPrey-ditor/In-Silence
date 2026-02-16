switch (triggerType) {
	case "Touching":
		if (place_meeting(x, y, obj_player)) {
			scr_apply_with_delay()
		}
		break;
	case "Interact":
		if (place_meeting(x, y, obj_player)) {
			if (scr_keyboard_check_keys_pressed(obj_player.keybinds.up)) {
				scr_apply_with_delay()
			}
		}
		break;
	case "OneTime":
		scr_apply_with_delay()
		
		var newList = array_concat(struct_get(obj_init.removeFromRoom, room_get_name(room)), [id])
		struct_set(obj_init.removeFromRoom, room_get_name(room), newList)
		
		instance_destroy()
}