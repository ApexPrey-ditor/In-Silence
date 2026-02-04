switch (triggerType) {
	case "Touching":
		if (place_meeting(x, y, obj_player)) {
			apply_with_delay()
		}
		break;
}