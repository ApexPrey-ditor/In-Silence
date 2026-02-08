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
}